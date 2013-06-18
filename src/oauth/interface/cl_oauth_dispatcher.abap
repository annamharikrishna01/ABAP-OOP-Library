class /OOP/CL_OAUTH_DISPATCHER definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_DISPATCHER
*"* do not include other source files here!!!

  interfaces /OOP/IF_DISPATCHER .
  interfaces IF_HTTP_EXTENSION .

  methods CONSTRUCTOR .
protected section.
*"* protected components of class /OOP/CL_OAUTH_DISPATCHER
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_DISPATCHER
*"* do not include other source files here!!!

  data _OAUTH_UTIL type ref to /OOP/CL_OAUTH_UTIL .
  data _OAUTH_SERVICE type ref to /OOP/CL_OAUTH_SERVICE .
  constants MAX_URI_LENGTH type I value 1000. "#EC NOTEXT

  methods _SERVICE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE
    raising
      /OOP/CX_RESOURCE_EXCEPTION .
  methods _GET_MAPPED_RESOURCE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
    returning
      value(RETURNING) type ref to /OOP/IF_RESOURCE
    raising
      /OOP/CX_URI_TOO_LONG .
ENDCLASS.



CLASS /OOP/CL_OAUTH_DISPATCHER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_DISPATCHER->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  create object _oauth_service.
  create object _oauth_util.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_DISPATCHER->IF_HTTP_EXTENSION~HANDLE_REQUEST
* +-------------------------------------------------------------------------------------------------+
* | [--->] SERVER                         TYPE REF TO IF_HTTP_SERVER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method if_http_extension~handle_request.
*/**
* This method is called by the SAP ICF system on handler classes
* Wraps the SAP request and response objects and let's the SERVICE method handle them
*/

  " Wrap request and response
  data request type ref to /oop/if_request.
  data response type ref to /oop/if_response.
  create object request
    type
    /oop/cl_request
    exporting
      request = server->request.
  create object response
    type
    /oop/cl_response
    exporting
      response = server->response.

  " Handle request
  data e type ref to /oop/cx_resource_exception.
  try.
      _service( request = request response = response ).
      return.
    catch /oop/cx_resource_exception into e.
      response->send_internal_server_error( message = e->message ).
      return.
  endtry.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_DISPATCHER->_GET_MAPPED_RESOURCE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_RESOURCE
* | [!CX!] /OOP/CX_URI_TOO_LONG
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _get_mapped_resource.
*/**
* Finds the resource mapped to the request URI.
* The resource is mapped using a URI pattern. When matching a request URI to a URI pattern, the following rules apply:
* 1. an exact path match is preferred over a wildcard path match
* 2. the longest pattern is preferred over shorter patterns
*
* Examples:
* - request URI: /partners/12/address
* - patterns:    /partners
*                /partners/*
*                /partners/*/address
* - result:      second and third match; the third pattern is chosen
*
* - request URI: /partners
* - patterns:    /partners
*                /partners/*
*                /partners/*/address
* - result:      all match; the first pattern is chosen
*/
  " Get request URI
  data uri type string.
  uri = request->get_requesturi( ).
  if strlen( uri ) > max_uri_length. " Maximum supported URI length
    raise exception type /oop/cx_uri_too_long.
  endif.
  translate uri to upper case.
  " Match URI to a URI pattern and its mapped resource
  " - Get all resources
  data th_resources type hashed table of /oop/resources with unique key resourceid.
  select * from /oop/resources into table th_resources where oauth = abap_true.
  if sy-subrc <> 0.
    return.
  endif.
  " - Find matching resources
  data th_matching_resources type hashed table of /oop/resources with unique key resourceid.
  field-symbols <resource> type /oop/resources.
  loop at th_resources assigning <resource>.
    if <resource>-uripattern is not initial. " Ignore empty patterns
      if uri cp <resource>-uripattern.
        insert <resource> into table th_matching_resources.
      endif.
    endif.
  endloop.
  " - Choose the best pattern
  data selected_resource type /oop/resources.
  " -- Look for an exact match first
  field-symbols <matching_resource> type /oop/resources.
  loop at th_matching_resources assigning <matching_resource>.
    if uri = <matching_resource>-uripattern.
      selected_resource = <matching_resource>.
      exit.
    endif.
  endloop.
  if selected_resource is initial.
    " -- If no exact match was found, choose the longest matching pattern
    data matching_pattern_length type i.
    loop at th_matching_resources assigning <matching_resource>.
      if strlen( <matching_resource>-uripattern ) > matching_pattern_length.
        selected_resource = <matching_resource>.
      endif.
      matching_pattern_length = strlen( <matching_resource>-uripattern ).
    endloop.
  endif.

  " Get the resource mapped to the chosen pattern and return it
  if selected_resource is not initial.
    data resource type ref to /oop/cl_resource.
    try.
        create object resource type (selected_resource-resourceclass).
        resource->_id = selected_resource-resourceid.
        resource->_uripattern = selected_resource-uripattern.
      catch cx_sy_create_object_error.
        " Do nothing; this method returns null if no resource was found
        return.
    endtry.
  endif.
  returning = resource.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_DISPATCHER->_SERVICE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* | [!CX!] /OOP/CX_RESOURCE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _service.
*/**
* Validates OAuth credentials and if valid,
* dispatches the HTTP request to the corresponding resource.
* Returns the NOT_FOUND status code for unknown resources.
* Returns the NOT_IMPLEMENTED status code for methods which are not supported.
* Supported methods:
* - DELETE
* - GET
* - POST
* - PUT
* - HEAD
*/
  data message type string. " Used for error messages

  " Init Repositories
  data client_repo type ref to /oop/if_oauth_client_repo.
  client_repo = /oop/cl_oauth_repo_factory=>client_repo( ).
  data oauth_request_repo type ref to /oop/if_oauth_request_repo.
  oauth_request_repo = /oop/cl_oauth_repo_factory=>request_repo( ).
  data permission_repo type ref to /oop/if_oauth_permission_repo.
  permission_repo = /oop/cl_oauth_repo_factory=>permission_repo( ).
  data token_repo type ref to /oop/if_oauth_token_repo.
  token_repo = /oop/cl_oauth_repo_factory=>token_repo( ).

  " Get the OAuth parameters
  data oauth_consumer_key type /oop/oa_consumer_key.
  oauth_consumer_key = request->get_parameter( /oop/cl_oauth_parameters=>oauth_consumer_key ).
  data oauth_nonce type /oop/oa_nonce.
  oauth_nonce = request->get_parameter( /oop/cl_oauth_parameters=>oauth_nonce ).
  data oauth_signature type /oop/oa_signature.
  oauth_signature = request->get_parameter( /oop/cl_oauth_parameters=>oauth_signature ).
  data oauth_signature_method type /oop/oa_signature_method.
  oauth_signature_method = request->get_parameter( /oop/cl_oauth_parameters=>oauth_signature_method ).
  data oauth_timestamp type /oop/oa_timestamp.
  oauth_timestamp = request->get_parameter( /oop/cl_oauth_parameters=>oauth_timestamp ).
  data oauth_token type /oop/oa_token.
  oauth_token = request->get_parameter( /oop/cl_oauth_parameters=>oauth_token ).
  data oauth_version type /oop/oa_version.
  oauth_version = request->get_parameter( /oop/cl_oauth_parameters=>oauth_version ).

  " Create base string
  data base_string type string.
  base_string = _oauth_util->base_string_from_request( request = request ).

  " Check if the request is unique
  data existing_oauth_request type ref to /oop/cl_oauth_request.
  existing_oauth_request = oauth_request_repo->find_by_id(
    consumer_key = oauth_consumer_key
    timestamp = oauth_timestamp
    nonce = oauth_nonce ).
  if existing_oauth_request is bound.
    " Duplicate request
    response->send_unauthorized( ).
    return.
  endif.

  " Save the request
  data oauth_request type ref to /oop/cl_oauth_request.
  create object oauth_request
    exporting
      consumer_key     = oauth_consumer_key
      timestamp        = oauth_timestamp
      nonce            = oauth_nonce
      signature        = oauth_signature
      signature_method = oauth_signature_method
      token            = oauth_token
      version          = oauth_version
      base_string      = base_string.
  try.
      oauth_request_repo->create( oauth_request ).
      commit work.
    catch /oop/cx_oauth_record_exists.
      " Duplicate request
      response->send_unauthorized( ).
      return.
  endtry.

  " Check if client exists
  data client type ref to /oop/cl_oauth_client.
  client = client_repo->find_by_id( oauth_consumer_key ).
  if client is not bound.
    " Unknown client
    response->send_unauthorized( ).
    return.
  endif.

  " Get the token
  data token type ref to /oop/cl_oauth_token.
  token = token_repo->find_by_id( oauth_token ).
  if token is not bound.
    " Unknown token
    response->send_unauthorized( ).
    return.
  endif.

  " Check if signature is valid
  " - Get client and token secret
  data client_secret type /oop/oa_client_secret.
  client_secret = client->secret( ).
  data token_secret type /oop/oa_token_secret.
  token_secret = token->secret( ).
  " Create expected signature
  data expected_signature type /oop/oa_signature.
  try.
      expected_signature = _oauth_util->create_signature( client_secret = client_secret token_secret = token_secret base_string = base_string ).
    catch /oop/cx_oauth_signature_error.
      " Problem generating secret
      response->send_internal_server_error( ).
      return.
  endtry.
  if expected_signature <> oauth_signature.
    " Invalid signature
    response->send_unauthorized( ).
    return.
  endif.

  " Check if the timestamp is not too old
  if _oauth_service->is_timestamp_valid( oauth_timestamp ) = abap_false.
    " Timestamp too old
    response->send_unauthorized( ).
    return.
  endif.

  " OAuth validation passed, continue processing the request

  " Update request (set to authorized)
  oauth_request->authorize( ).
  try.
      oauth_request_repo->update( oauth_request ).
      commit work.
    catch /oop/cx_oauth_record_not_found.
      " Database error
      response->send_internal_server_error( ).
      return.
  endtry.

  " Find the resource mapped to the request URI
  data resource type ref to /oop/if_resource.
  try.
      resource = _get_mapped_resource( request = request ).
    catch /oop/cx_uri_too_long.
      " Too long URI
      message e004(/oop/rest) into message.
      response->send_error( code = /oop/cl_http_status_codes=>requesturi_too_large message = message ).
      return.
  endtry.
  if resource is not bound.
    " Unknown resource
    message e003(/oop/rest) into message.
    response->send_not_found( message = message ).
    return.
  endif.

  " Get the OAuth permission for this resource
  data client_id type /oop/oa_client_id.
  client_id = client->id( ).
  data resource_id type /oop/resourceid.
  resource_id = resource->id( ).
  data permission type ref to /oop/cl_oauth_permission.
  permission = permission_repo->find_by_id( client_id = client_id resource_id = resource_id ).
  if permission is not bound.
    " No permissions defined for this resource
    response->send_unauthorized( ).
    return.
  endif.

  " If the permission allows it, dispatch request to the requested resource
  data method type string.
  method = request->get_method( ).
  case method.
    when /oop/cl_http_methods=>delete.
      if permission->delete_allowed( ) = abap_true.
        resource->delete( request = request response = response ).
      else.
        response->send_unauthorized( ).
        return.
      endif.
    when /oop/cl_http_methods=>get.
      if permission->read_allowed( ) = abap_true.
        resource->read( request = request response = response ).
      else.
        response->send_unauthorized( ).
        return.
      endif.
    when /oop/cl_http_methods=>post.
      if permission->create_allowed( ) = abap_true.
        resource->create( request = request response = response ).
      else.
        response->send_unauthorized( ).
        return.
      endif.
    when /oop/cl_http_methods=>put.
      if permission->update_allowed( ) = abap_true.
        resource->update( request = request response = response ).
      else.
        response->send_unauthorized( ).
        return.
      endif.
    when /oop/cl_http_methods=>head.
      if permission->head_allowed( ) = abap_true.
        resource->head( request = request response = response ).
      else.
        response->send_unauthorized( ).
        return.
      endif.
    when others.
      " Unsupported HTTP method
      message e002(/oop/rest) into message.
      response->send_error( code = /oop/cl_http_status_codes=>not_implemented message = message ).
      return.
  endcase.
endmethod.
ENDCLASS.
