class /OOP/CL_OAUTH_BSP_AUTH_CONTR definition
  public
  inheriting from CL_BSP_CONTROLLER2
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_BSP_AUTH_CONTR
*"* do not include other source files here!!!

  constants TOKEN_NOT_FOUND type I value 0. "#EC NOTEXT
  constants TOKEN_ALREADY_AUTHORIZED type I value 1. "#EC NOTEXT
  constants CLIENT_NOT_FOUND type I value 2. "#EC NOTEXT
  constants TOKEN_AUTHENTICITY_INVALID type I value 3. "#EC NOTEXT

  methods DO_REQUEST
    redefinition .
protected section.
*"* protected components of class /OOP/CL_OAUTH_BSP_AUTH_CONTR
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_BSP_AUTH_CONTR
*"* do not include other source files here!!!

  methods _ERROR
    importing
      !ERROR_TYPE type I .
  methods _AUTHORIZED
    importing
      !TMP_TOKEN type ref to /OOP/CL_OAUTH_TMP_TOKEN .
  methods _INDEX
    importing
      !OAUTH_TOKEN type /OOP/OA_TOKEN
      !MESSAGE type STRING optional .
  methods _AUTHORIZE
    importing
      !TMP_TOKEN type ref to /OOP/CL_OAUTH_TMP_TOKEN .
ENDCLASS.



CLASS /OOP/CL_OAUTH_BSP_AUTH_CONTR IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_BSP_AUTH_CONTR->DO_REQUEST
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method do_request.
  " Dispatch input
  dispatch_input( ).

  " Do not call default view if navigation was requested
  if is_navigation_requested( ) is not initial.
    return.
  endif.

  " Get token parameter
  data oauth_token type /oop/oa_token.
  oauth_token = request->get_form_field_cs( /oop/cl_oauth_parameters=>oauth_token ).

  " Switch user if username and password were sent
  data username type xubname.
  username = request->get_form_field_cs( `username` ).      "#EC NOTEXT
  data password type bapipwd.
  password-bapipwd = request->get_form_field_cs( `password` ). "#EC NOTEXT
  if username is not initial or password is not initial.
    data userswitch_success type abap_bool.
    userswitch_success = abap_true.
    data return type standard table of bapiret2.
    call function 'SUSR_INTERNET_USERSWITCH'
      exporting
        username                    = username
        password                    = password
      tables
        return                      = return
      exceptions
        current_user_not_servicetyp = 1
        more_than_one_mode          = 2
        internal_error              = 3
        others                      = 4.
    if sy-subrc <> 0.
      userswitch_success = abap_false.
    endif.
    " - Also check bapireturn for errors
    field-symbols <return> type bapiret2.
    loop at return assigning <return> where type <> `S`.
      userswitch_success = abap_false.
    endloop.
    if userswitch_success = abap_false.
      " Switch failed, display login form again with error message
      data msg type string.
      msg = text-001.
      _index( oauth_token = oauth_token message = msg ).
      return.
    endif.
  else.
    " Check if already switched to dialog user
    call function 'SUSR_USER_IS_SERVICETYPE'
      exporting
        user_name               = sy-uname
      exceptions
        user_name_not_exists    = 1
        user_is_not_servicetype = 2
        others                  = 3.
    if sy-subrc = 0.
      " Not yet switched to dialog user, display login form
      _index( oauth_token ).
      return.
    endif.
  endif.

  " Get the token
  data tmp_token_repo type ref to /oop/if_oauth_tmp_token_repo.
  tmp_token_repo = /oop/cl_oauth_repo_factory=>tmp_token_repo( ).
  data tmp_token type ref to /oop/cl_oauth_tmp_token.
  tmp_token = tmp_token_repo->find_by_id( oauth_token ).
  if tmp_token is not bound.
    " Token not found
    _error( token_not_found ).
    return.
  endif.

  " Check if token is not already authorized
  if tmp_token->authorized_by( ) is not initial.
    " Token already authorized
    _error( token_already_authorized ).
    return.
  endif.

  " Check for authorize POST request
  data authenticity_token type string.
  authenticity_token = request->get_form_field_cs( `authenticity_token` ). "#EC NOTEXT
  if authenticity_token is not initial or tmp_token->authenticity_token( ) is not initial.
    if authenticity_token = tmp_token->authenticity_token( ).
      " User submitted authorize form
      _authorized( tmp_token ).
      return.
    else.
      " Invalid POST request (possible fraud attempt)
      _error( token_authenticity_invalid ).
      return.
    endif.
  else.
    " Initial request, display authorize form
    _authorize( tmp_token ).
    return.
  endif.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_BSP_AUTH_CONTR->_AUTHORIZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] TMP_TOKEN                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _authorize.
  data oauth_token type /oop/oa_token.
  oauth_token = tmp_token->token( ).

  " Get the client details
  data client_id type /oop/oa_client_id.
  client_id = tmp_token->client_id( ).
  data client_repo type ref to /oop/if_oauth_client_repo.
  client_repo = /oop/cl_oauth_repo_factory=>client_repo( ).
  data client type ref to /oop/cl_oauth_client.
  client = client_repo->find_by_id( client_id ).
  if client is not bound.
    " Unknown client
    _error( client_not_found ).
    return.
  endif.
  data client_name type /oop/oa_client_name.
  client_name = client->name( ).
  data client_description type /oop/oa_client_description.
  client_description = client->description( ).
  data client_company type /oop/oa_client_company.
  client_company = client->company( ).
  data client_url type /oop/oa_client_url.
  client_url = client->url( ).

  " Get permissions
  data permission_repo type ref to /oop/if_oauth_permission_repo.
  permission_repo = /oop/cl_oauth_repo_factory=>permission_repo( ).
  data permissions type ref to /oop/if_list.
  permissions = permission_repo->find_by_client_id( client_id ).

  " Generate authenticity token and save it
  data oauth_util type ref to /oop/cl_oauth_util.
  create object oauth_util.
  data authenticity_token type /oop/oa_authenticity_token.
  authenticity_token = oauth_util->new_authenticity_token( ).
  tmp_token->set_authenticity_token( authenticity_token ).
  data tmp_token_repo type ref to /oop/if_oauth_tmp_token_repo.
  tmp_token_repo = /oop/cl_oauth_repo_factory=>tmp_token_repo( ).
  try.
      tmp_token_repo->update( tmp_token ).
      commit work.
    catch /oop/cx_oauth_record_not_found.
      " Token does not exist
      _error( token_not_found ).
  endtry.

  " Get the callback
  data oauth_callback type /oop/oa_callback.
  oauth_callback = tmp_token->callback( ).

  " Create authorize view
  data authorize_view type ref to if_bsp_page.
  authorize_view = create_view( view_name = `authorize.html` ). "#EC NOTEXT

  " Populate view attributes
  authorize_view->set_attribute( name = `authenticity_token` value = authenticity_token ). "#EC NOTEXT
  authorize_view->set_attribute( name = `client_company` value = client_company ). "#EC NOTEXT
  authorize_view->set_attribute( name = `client_description` value = client_description ). "#EC NOTEXT
  authorize_view->set_attribute( name = `client_name` value = client_name ). "#EC NOTEXT
  authorize_view->set_attribute( name = `client_url` value = client_url ). "#EC NOTEXT
  authorize_view->set_attribute( name = `oauth_token` value = oauth_token ). "#EC NOTEXT
  authorize_view->set_attribute( name = `oauth_callback` value = oauth_callback ). "#EC NOTEXT
  authorize_view->set_attribute( name = `permissions` value = permissions ). "#EC NOTEXT

  " Call authorize view
  call_view( authorize_view ).
  return.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_BSP_AUTH_CONTR->_AUTHORIZED
* +-------------------------------------------------------------------------------------------------+
* | [--->] TMP_TOKEN                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _authorized.
  " Authorize and save the token
  tmp_token->authorize( ).
  data tmp_token_repo type ref to /oop/if_oauth_tmp_token_repo.
  tmp_token_repo = /oop/cl_oauth_repo_factory=>tmp_token_repo( ).
  try.
      tmp_token_repo->update( tmp_token ).
      commit work.
    catch /oop/cx_oauth_record_not_found.
      " Token does not exist
      _error( token_not_found ).
  endtry.

  data oauth_token type /oop/oa_token.
  oauth_token = tmp_token->token( ).

  " Get the verifier
  data oauth_verifier type /oop/oa_verifier.
  oauth_verifier = tmp_token->verifier( ).

  " Get the callback
  data oauth_callback type /oop/oa_callback.
  oauth_callback = tmp_token->callback( ).

  " Create authorized view
  data authorized_view type ref to if_bsp_page.
  authorized_view = create_view( view_name = `authorized.html` ). "#EC NOTEXT

  " Populate view attributes
  authorized_view->set_attribute( name = `oauth_callback` value = oauth_callback ). "#EC NOTEXT
  authorized_view->set_attribute( name = `oauth_token` value = oauth_token ). "#EC NOTEXT
  authorized_view->set_attribute( name = `oauth_verifier` value = oauth_verifier ). "#EC NOTEXT

  " Call authorized view
  call_view( authorized_view ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_BSP_AUTH_CONTR->_ERROR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ERROR_TYPE                     TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _error.
  " Create error view
  data error_view type ref to if_bsp_page.
  error_view = create_view( view_name = `error.html` ).     "#EC NOTEXT

  " Set error type
  error_view->set_attribute( name = `error_type` value = error_type ). "#EC NOTEXT

  " Call error view
  call_view( error_view ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_BSP_AUTH_CONTR->_INDEX
* +-------------------------------------------------------------------------------------------------+
* | [--->] OAUTH_TOKEN                    TYPE        /OOP/OA_TOKEN
* | [--->] MESSAGE                        TYPE        STRING(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _index.
  " Create index view
  data index_view type ref to if_bsp_page.
  index_view = create_view( view_name = `index.html` ).     "#EC NOTEXT

  index_view->set_attribute( name = `oauth_token` value = oauth_token ). "#EC NOTEXT
  index_view->set_attribute( name = `message` value = message ). "#EC NOTEXT

  " Call index view
  call_view( index_view ).
  return.
endmethod.
ENDCLASS.
