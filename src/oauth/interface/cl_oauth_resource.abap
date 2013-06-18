class /OOP/CL_OAUTH_RESOURCE definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_RESOURCE
*"* do not include other source files here!!!

  interfaces IF_HTTP_EXTENSION .

  methods CONSTRUCTOR .
protected section.
*"* protected components of class /OOP/CL_OAUTH_RESOURCE
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_RESOURCE
*"* do not include other source files here!!!

  data _OAUTH_UTIL type ref to /OOP/CL_OAUTH_UTIL .
  data _OAUTH_SERVICE type ref to /OOP/CL_OAUTH_SERVICE .

  methods _INITIATE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods _AUTHORIZE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods _TOKEN
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
ENDCLASS.



CLASS /OOP/CL_OAUTH_RESOURCE IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_RESOURCE->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  create object _oauth_util.
  create object _oauth_service.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_RESOURCE->IF_HTTP_EXTENSION~HANDLE_REQUEST
* +-------------------------------------------------------------------------------------------------+
* | [--->] SERVER                         TYPE REF TO IF_HTTP_SERVER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method if_http_extension~handle_request.
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
  " Dispatch
  data uri type string.
  uri = request->get_requesturi( ).
  case uri.
    when `/initiate`.
      " Temporary Credentials
      _initiate( request = request response = response ).
      return.
    when `/authorize`.
      " Resource Owner Authorization
      _authorize( request = request response = response ).
      return.
    when `/token`.
      " Token Credentials
      _token( request = request response = response ).
      return.
    when others.
      response->send_not_found( ).
      return.
  endcase.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_RESOURCE->_AUTHORIZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _authorize.
  " Get the OAuth token
  data oauth_token type /oop/oa_token.
  oauth_token = request->get_parameter( /oop/cl_oauth_parameters=>oauth_token ).

  " Redirect to BSP authorize app
  data redirect_path type string.
  concatenate `/sap/bc/bsp/oop/oauth_authorize/authorize.do?oauth_token=` oauth_token into redirect_path.
  response->redirect( redirect_path ).
  return.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_RESOURCE->_INITIATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _initiate.
  " Must be a POST request
  if request->get_method( ) <> /oop/cl_http_methods=>post.
    response->send_bad_request( ).
    return.
  endif.

  " Get the OAuth parameters
  data oauth_callback type /oop/oa_callback.
  oauth_callback = request->get_parameter( /oop/cl_oauth_parameters=>oauth_callback ).
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

  " Check if client exists
  data client_repo type ref to /oop/if_oauth_client_repo.
  client_repo = /oop/cl_oauth_repo_factory=>client_repo( ).
  data client type ref to /oop/cl_oauth_client.
  client = client_repo->find_by_id( oauth_consumer_key ).
  if client is not bound.
    " Unknown client
    response->send_unauthorized( ).
    return.
  endif.

  " Check if signature is valid
  " - Create base string
  data base_string type string.
  base_string = _oauth_util->base_string_from_request( request = request ).
  " - Get client and token secret
  data client_secret type /oop/oa_client_secret.
  client_secret = client->secret( ).
  data token_secret type /oop/oa_token_secret.
  token_secret = ``. " No token secret for the initiate process
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

  " Check if the request is unique
  data initiate_request_repo type ref to /oop/if_oauth_tmp_req_ini_repo.
  initiate_request_repo = /oop/cl_oauth_repo_factory=>tmp_req_ini_repo( ).
  data existing_initiate_request type ref to /oop/cl_oauth_tmp_req_ini.
  existing_initiate_request = initiate_request_repo->find_by_id(
    consumer_key = oauth_consumer_key
    timestamp = oauth_timestamp
    nonce = oauth_nonce ).
  if existing_initiate_request is bound.
    " Duplicate request
    response->send_unauthorized( ).
    return.
  endif.

  " Check if the timestamp is not too old
  if _oauth_service->is_timestamp_valid( oauth_timestamp ) = abap_false.
    " Timestamp too old
    response->send_unauthorized( ).
    return.
  endif.

  " Save the request
  data initiate_request type ref to /oop/cl_oauth_tmp_req_ini.
  create object initiate_request
    exporting
      consumer_key     = oauth_consumer_key
      timestamp        = oauth_timestamp
      nonce            = oauth_nonce
      callback         = oauth_callback
      signature        = oauth_signature
      signature_method = oauth_signature_method
      token            = oauth_token
      version          = oauth_version.
  try.
      initiate_request_repo->create( initiate_request ).
      commit work.
    catch /oop/cx_oauth_record_exists.
      " Duplicate request
      response->send_unauthorized( ).
      return.
  endtry.

  " Generate temporary token
  data tmp_token type ref to /oop/cl_oauth_tmp_token.
  tmp_token = _oauth_service->new_tmp_token( client_id = oauth_consumer_key callback = oauth_callback ).

  " Return the token details as application/x-www-form-urlencoded string
  data response_string type string.
  data response_token type /oop/oa_token.
  response_token = tmp_token->token( ).
  data response_secret type /oop/oa_token_secret.
  response_secret = tmp_token->secret( ).
  concatenate `oauth_token=` response_token `&oauth_token_secret=` response_secret `&oauth_callback_confirmed=true` into response_string. "#EC NOTEXT
  response->send_text( data = response_string mime_type = /oop/cl_http_mime_types=>application_x_www_form_urlenc ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_RESOURCE->_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _token.
  " Must be a POST request
  if request->get_method( ) <> /oop/cl_http_methods=>post.
    response->send_bad_request( ).
    return.
  endif.

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
  data oauth_verifier type /oop/oa_verifier.
  oauth_verifier = request->get_parameter( /oop/cl_oauth_parameters=>oauth_verifier ).
  data oauth_version type /oop/oa_version.
  oauth_version = request->get_parameter( /oop/cl_oauth_parameters=>oauth_version ).

  " Check if client exists
  data client_repo type ref to /oop/if_oauth_client_repo.
  client_repo = /oop/cl_oauth_repo_factory=>client_repo( ).
  data client type ref to /oop/cl_oauth_client.
  client = client_repo->find_by_id( oauth_consumer_key ).
  if client is not bound.
    " Unknown client
    response->send_unauthorized( ).
    return.
  endif.

  " Get the token
  data tmp_token_repo type ref to /oop/if_oauth_tmp_token_repo.
  tmp_token_repo = /oop/cl_oauth_repo_factory=>tmp_token_repo( ).
  data tmp_token type ref to /oop/cl_oauth_tmp_token.
  tmp_token = tmp_token_repo->find_by_id( oauth_token ).
  if tmp_token is not bound.
    " Unknown token
    response->send_unauthorized( ).
    return.
  endif.

  " Check if signature is valid
  " - Create base string
  data base_string type string.
  base_string = _oauth_util->base_string_from_request( request = request ).
  " - Get client and token secret
  data client_secret type /oop/oa_client_secret.
  client_secret = client->secret( ).
  data token_secret type /oop/oa_token_secret.
  token_secret = tmp_token->secret( ).
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

  " Check if the request is unique
  data token_request_repo type ref to /oop/if_oauth_tmp_req_aut_repo.
  token_request_repo = /oop/cl_oauth_repo_factory=>tmp_req_aut_repo( ).
  data existing_token_request type ref to /oop/cl_oauth_tmp_req_aut.
  existing_token_request = token_request_repo->find_by_id(
    consumer_key = oauth_consumer_key
    timestamp = oauth_timestamp
    nonce = oauth_nonce ).
  if existing_token_request is bound.
    " Duplicate request
    response->send_unauthorized( ).
    return.
  endif.

  " Check if the timestamp is not too old
  if _oauth_service->is_timestamp_valid( oauth_timestamp ) = abap_false.
    " Timestamp too old
    response->send_unauthorized( ).
    return.
  endif.

  " Save the request
  data token_request type ref to /oop/cl_oauth_tmp_req_aut.
  create object token_request
    exporting
      consumer_key     = oauth_consumer_key
      timestamp        = oauth_timestamp
      nonce            = oauth_nonce
      signature        = oauth_signature
      signature_method = oauth_signature_method
      token            = oauth_token
      verifier         = oauth_verifier
      version          = oauth_version.
  try.
      token_request_repo->create( token_request ).
      commit work.
    catch /oop/cx_oauth_record_exists.
      " Duplicate request
      response->send_unauthorized( ).
      return.
  endtry.

  " Get the username for which the token will be created
  data username type xubname.
  username = tmp_token->authorized_by( ).

  " Delete the temporary token
  tmp_token_repo->delete( tmp_token ).
  commit work.

  " Generate token
  data token type ref to /oop/cl_oauth_token.
  token = _oauth_service->new_token( client_id = oauth_consumer_key username = username ).

  " Return the token details as application/x-www-form-urlencoded string
  data response_string type string.
  data response_token type /oop/oa_token.
  response_token = token->token( ).
  data response_secret type /oop/oa_token_secret.
  response_secret = token->secret( ).
  concatenate `oauth_token=` response_token `&oauth_token_secret=` response_secret into response_string. "#EC NOTEXT
  response->send_text( data = response_string mime_type = /oop/cl_http_mime_types=>application_x_www_form_urlenc ).
endmethod.
ENDCLASS.
