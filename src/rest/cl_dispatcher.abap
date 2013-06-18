class /OOP/CL_DISPATCHER definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_DISPATCHER
*"* do not include other source files here!!!

  interfaces /OOP/IF_DISPATCHER .
  interfaces IF_HTTP_EXTENSION .
protected section.
*"* protected components of class /OOP/CL_DISPATCHER
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_DISPATCHER
*"* do not include other source files here!!!

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



CLASS /OOP/CL_DISPATCHER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_DISPATCHER->IF_HTTP_EXTENSION~HANDLE_REQUEST
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
* | Instance Private Method /OOP/CL_DISPATCHER->_GET_MAPPED_RESOURCE
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
  select * from /oop/resources into table th_resources where oauth = abap_false.
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
* | Instance Private Method /OOP/CL_DISPATCHER->_SERVICE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* | [!CX!] /OOP/CX_RESOURCE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _service.
*/**
* Dispatches the HTTP request to the corresponding resource.
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
  " Find the resource mapped to the request URI
  data resource type ref to /oop/if_resource.
  try.
      resource = _get_mapped_resource( request ).
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
  " Dispatch request to the requested resource
  data method type string.
  method = request->get_method( ).
  case method.
    when /oop/cl_http_methods=>delete.
      resource->delete( request = request response = response ).
    when /oop/cl_http_methods=>get.
      resource->read( request = request response = response ).
    when /oop/cl_http_methods=>post.
      resource->create( request = request response = response ).
    when /oop/cl_http_methods=>put.
      resource->update( request = request response = response ).
    when /oop/cl_http_methods=>head.
      resource->head( request = request response = response ).
    when others.
      " Unsupported HTTP method
      message e002(/oop/rest) into message.
      response->send_error( code = /oop/cl_http_status_codes=>not_implemented message = message ).
      return.
  endcase.
endmethod.
ENDCLASS.
