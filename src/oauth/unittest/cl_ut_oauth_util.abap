class /OOP/CL_UT_OAUTH_UTIL definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.
*"* public components of class /OOP/CL_UT_OAUTH_UTIL
*"* do not include other source files here!!!
protected section.
*"* protected components of class /OOP/CL_UT_OAUTH_UTIL
*"* do not include other source files here!!!

  data TESTED_OAUTH_UTIL type ref to /OOP/CL_OAUTH_UTIL .

  methods BASE_STRING_FROM_REQUEST
  for testing .
  methods CREATE_BASE_STRING
  for testing .
  methods CREATE_SIGNATURE
  for testing .
  methods NEW_AUTHENTICITY_TOKEN
  for testing .
  methods NEW_CLIENT_ID
  for testing .
  methods NEW_CLIENT_SECRET
  for testing .
  methods NEW_TOKEN
  for testing .
  methods NEW_TOKEN_SECRET
  for testing .
  methods NEW_VERIFIER
  for testing .
  methods UNIX_TIMESTAMP
  for testing .
private section.
*"* private components of class /OOP/CL_UT_OAUTH_UTIL
*"* do not include other source files here!!!

  methods SETUP .
ENDCLASS.



CLASS /OOP/CL_UT_OAUTH_UTIL IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->BASE_STRING_FROM_REQUEST
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method base_string_from_request.
  " Use HTTP client class to simulate a request object
  data client type ref to if_http_client.
  call method cl_http_client=>create_by_url
    exporting
      url                = `http://host.net/resource`
    importing
      client             = client
    exceptions
      argument_not_found = 1
      plugin_not_active  = 2
      internal_error     = 3
      others             = 4.
  if sy-subrc <> 0.
    cl_aunit_assert=>fail( ).
    return.
  endif.

  client->request->set_method( `GET` ).

  data header_fields type tihttpnvp.
  data header_field type ihttpnvp.
  header_field-name = `~uri_scheme_expanded`.
  header_field-value = `HTTP`.
  append header_field to header_fields.
  header_field-name = `~server_name_expanded`.
  header_field-value = `host.net`.
  append header_field to header_fields.
  header_field-name = `~server_port_expanded`.
  header_field-value = `80`.
  append header_field to header_fields.
  header_field-name = `~path`.
  header_field-value = `/resource`.
  append header_field to header_fields.
  client->request->set_header_fields( header_fields ).

  data request_parameters type tihttpnvp.
  data request_parameter type ihttpnvp.
  request_parameter-name = `name1`.
  request_parameter-value = `value1`.
  append request_parameter to request_parameters.
  request_parameter-name = `name2`.
  request_parameter-value = `value2`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_consumer_key.
  request_parameter-value = `abcd`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_nonce.
  request_parameter-value = `Utx8O826PN7`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_signature.
  request_parameter-value = `1okMwXNliwxpe8SLWJD+bgUUy8Y=`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_signature_method.
  request_parameter-value = `HMAC-SHA1`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_timestamp.
  request_parameter-value = `1356023602`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_token.
  request_parameter-value = `ijkl`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_version.
  request_parameter-value = `1.0`.
  append request_parameter to request_parameters.

  client->request->set_form_fields( request_parameters ).

  " Wrap request
  data request type ref to /oop/cl_request.
  create object request
    exporting
      request = client->request.

  data base_string type string.
  base_string = tested_oauth_util->base_string_from_request( request = request ).

  data exp type string.
  concatenate exp `GET&http%3A%2F%2Fhost.net%2Fresource&name1%3Dvalue1%26name2%3Dvalue2%26oauth_consumer_key` into exp.
  concatenate exp `%3Dabcd%26oauth_nonce%3DUtx8O826PN7%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1356023602%26oauth_token%3Dijkl%26oauth_version%3D1.0` into exp.

  cl_aunit_assert=>assert_equals( act = base_string exp = exp ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->CREATE_BASE_STRING
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_base_string.
  data request_method type string.
  data base_string_uri type string.
  data request_parameters type tihttpnvp.
  data request_parameter type ihttpnvp.

  request_method = `GET`.
  base_string_uri = `http://host.net/resource`.

  request_parameter-name = `name1`.
  request_parameter-value = `value1`.
  append request_parameter to request_parameters.
  request_parameter-name = `name2`.
  request_parameter-value = `value2`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_consumer_key.
  request_parameter-value = `abcd`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_nonce.
  request_parameter-value = `Utx8O826PN7`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_signature.
  request_parameter-value = `1okMwXNliwxpe8SLWJD+bgUUy8Y=`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_signature_method.
  request_parameter-value = `HMAC-SHA1`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_timestamp.
  request_parameter-value = `1356023602`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_token.
  request_parameter-value = `ijkl`.
  append request_parameter to request_parameters.
  request_parameter-name = /oop/cl_oauth_parameters=>oauth_version.
  request_parameter-value = `1.0`.
  append request_parameter to request_parameters.

  data base_string type string.
  base_string = tested_oauth_util->create_base_string( request_method = request_method base_string_uri = base_string_uri request_parameters = request_parameters ).

  data exp type string.
  concatenate exp `GET&http%3A%2F%2Fhost.net%2Fresource&name1%3Dvalue1%26name2%3Dvalue2%26oauth_consumer_key` into exp.
  concatenate exp `%3Dabcd%26oauth_nonce%3DUtx8O826PN7%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1356023602%26oauth_token%3Dijkl%26oauth_version%3D1.0` into exp.

  cl_aunit_assert=>assert_equals( act = base_string exp = exp ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->CREATE_SIGNATURE
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_signature.
  data client_secret type /oop/oa_client_secret.
  client_secret = `efgh`.
  data token_secret type /oop/oa_token_secret.
  token_secret = `mnop`.
  data base_string type string.
  base_string = `GET&http%3A%2F%2Fhost.net%2Fresource&name%3Dvalue%26name%3Dvalue%26oauth_consumer_key%3Dabcd%26oauth_nonce%3DxTuPv8scUWG%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1355995974%26oauth_token%3Dijkl%26oauth_version%3D1.0`.
  data signature type string.
  try.
      signature = tested_oauth_util->create_signature( client_secret = client_secret token_secret = token_secret base_string = base_string ).
    catch /oop/cx_oauth_signature_error.
      cl_aunit_assert=>fail( ).
  endtry.
  cl_aunit_assert=>assert_equals( act = signature exp = `xg/8Bsu8E04Qf8QzTr95Icr4Fs0=` ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_AUTHENTICITY_TOKEN
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_authenticity_token.
  data authenticity_token type /oop/oa_authenticity_token.
  authenticity_token = tested_oauth_util->new_authenticity_token( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{40}$` text = authenticity_token ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_client_id.
  data client_id type /oop/oa_client_id.
  client_id = tested_oauth_util->new_client_id( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{6}$` text = client_id ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_CLIENT_SECRET
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_client_secret.
  data client_secret type /oop/oa_client_secret.
  client_secret = tested_oauth_util->new_client_secret( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{40}$` text = client_secret ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_TOKEN
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_token.
  data token type /oop/oa_token.
  token = tested_oauth_util->new_token( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{40}$` text = token ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_TOKEN_SECRET
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_token_secret.
  data token_secret type /oop/oa_token_secret.
  token_secret = tested_oauth_util->new_token_secret( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{40}$` text = token_secret ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->NEW_VERIFIER
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_verifier.
  data verifier type /oop/oa_verifier.
  verifier = tested_oauth_util->new_verifier( ).
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[A-Za-z0-9]{6}$` text = verifier ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_UT_OAUTH_UTIL->SETUP
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method setup.
  create object tested_oauth_util.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method /OOP/CL_UT_OAUTH_UTIL->UNIX_TIMESTAMP
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method unix_timestamp.
  data unix_timestamp type i.
  unix_timestamp = tested_oauth_util->unix_timestamp( ).
  data unix_timestamp_str type string.
  unix_timestamp_str = unix_timestamp.
  condense unix_timestamp_str.
  data match type abap_bool.
  match = cl_abap_matcher=>matches( pattern = `^[1-2]{1}[0-9]{8,9}$` text = unix_timestamp_str ).
  cl_aunit_assert=>assert_equals( act = match exp = abap_true ).
endmethod.
ENDCLASS.
