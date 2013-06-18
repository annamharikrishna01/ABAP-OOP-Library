class /OOP/CL_OAUTH_SERVICE definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_SERVICE
*"* do not include other source files here!!!

  constants MAX_TIMESTAMP_AGE type I value 7200. "#EC NOTEXT
  constants MAX_TMP_TOKEN_AGE type I value 7200. "#EC NOTEXT

  methods CONSTRUCTOR .
  methods NEW_CLIENT
    importing
      !NAME type /OOP/OA_CLIENT_NAME
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION
      !COMPANY type /OOP/OA_CLIENT_COMPANY
      !URL type /OOP/OA_CLIENT_URL
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_CLIENT .
  methods NEW_TMP_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !CALLBACK type /OOP/OA_CALLBACK
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TMP_TOKEN .
  methods NEW_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !USERNAME type XUBNAME
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TOKEN .
  type-pools ABAP .
  methods IS_TIMESTAMP_VALID
    importing
      !TIMESTAMP type /OOP/OA_TIMESTAMP
    returning
      value(RETURNING) type ABAP_BOOL .
  methods CLEANUP .
protected section.
*"* protected components of class /OOP/CL_OAUTH_SERVICE
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_SERVICE
*"* do not include other source files here!!!

  data _OAUTH_UTIL type ref to /OOP/CL_OAUTH_UTIL .

  methods _CREATE_AND_SAVE_CLIENT
    importing
      !NAME type /OOP/OA_CLIENT_NAME
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION
      !COMPANY type /OOP/OA_CLIENT_COMPANY
      !URL type /OOP/OA_CLIENT_URL
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_CLIENT .
  methods _CREATE_CLIENT
    importing
      !NAME type /OOP/OA_CLIENT_NAME
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION
      !COMPANY type /OOP/OA_CLIENT_COMPANY
      !URL type /OOP/OA_CLIENT_URL
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_CLIENT .
  methods _CREATE_AND_SAVE_TMP_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !CALLBACK type /OOP/OA_CALLBACK
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TMP_TOKEN .
  methods _CREATE_TMP_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !CALLBACK type /OOP/OA_CALLBACK
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TMP_TOKEN .
  methods _CREATE_AND_SAVE_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !USERNAME type XUBNAME
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TOKEN .
  methods _CREATE_TOKEN
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !USERNAME type XUBNAME
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TOKEN .
ENDCLASS.



CLASS /OOP/CL_OAUTH_SERVICE IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->CLEANUP
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method cleanup.

  " Delete old requests
  data request_check_timestamp type i.
  request_check_timestamp = _oauth_util->unix_timestamp( ).
  request_check_timestamp = request_check_timestamp - max_timestamp_age.
  " - API requests
  delete from /oop/oa_requests where timestamp < request_check_timestamp.
  if sy-subrc = 0.
    commit work.
  endif.
  " - Initiate requests
  delete from /oop/oa_tmp_auth where timestamp < request_check_timestamp.
  if sy-subrc = 0.
    commit work.
  endif.
  " - Authorize requests
  delete from /oop/oa_tmp_init where timestamp < request_check_timestamp.
  if sy-subrc = 0.
    commit work.
  endif.

  " Delete expired temporary tokens
  data tmp_token_check_created_at type tzntstmps.
  get time stamp field tmp_token_check_created_at.
  tmp_token_check_created_at = cl_abap_tstmp=>subtractsecs( tstmp = tmp_token_check_created_at secs = max_tmp_token_age ).
  delete from /oop/oa_tmp_toke where created_at < tmp_token_check_created_at.
  if sy-subrc = 0.
    commit work.
  endif.

  " Delete unused tokens
  " - Tokens which were created more than an hour ago and never accessed
  data unused_token_check_created_at type tzntstmps.
  get time stamp field unused_token_check_created_at.
  unused_token_check_created_at = cl_abap_tstmp=>subtractsecs( tstmp = unused_token_check_created_at secs = 3600 ).
  delete from /oop/oa_tokens
    where created_at < unused_token_check_created_at and
          last_access_at = 0.
  if sy-subrc = 0.
    commit work.
  endif.
  " - Tokens which were last accessed more than 60 days ago
  data token_check_last_access_at type tzntstmps.
  get time stamp field token_check_last_access_at.
  token_check_last_access_at = cl_abap_tstmp=>subtractsecs( tstmp = token_check_last_access_at secs = 5184000 ).
  delete from /oop/oa_tokens where last_access_at < token_check_last_access_at.
  if sy-subrc = 0.
    commit work.
  endif.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  create object _oauth_util.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->IS_TIMESTAMP_VALID
* +-------------------------------------------------------------------------------------------------+
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method is_timestamp_valid.
  data timestamp_difference type i.
  timestamp_difference = _oauth_util->unix_timestamp( ) - timestamp.
  if timestamp_difference > max_timestamp_age.
    returning = abap_false.
    return.
  else.
    returning = abap_true.
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->NEW_CLIENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_client.
  " Create the client
  data client type ref to /oop/cl_oauth_client.
  client = _create_and_save_client( name = name description = description company = company url = url ).
  " Return the client
  returning = client.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->NEW_TMP_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] CALLBACK                       TYPE        /OOP/OA_CALLBACK
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_tmp_token.
  " Create the temporary token
  data tmp_token type ref to /oop/cl_oauth_tmp_token.
  tmp_token = _create_and_save_tmp_token( client_id = client_id callback = callback ).
  " Return the temporary token
  returning = tmp_token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_SERVICE->NEW_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] USERNAME                       TYPE        XUBNAME
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_token.
  " Create the token
  data token type ref to /oop/cl_oauth_token.
  token = _create_and_save_token( client_id = client_id username = username ).
  " Return the token
  returning = token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_AND_SAVE_CLIENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_and_save_client.
  " Create and save the client into the database
  data client_repo type ref to /oop/if_oauth_client_repo.
  client_repo = /oop/cl_oauth_repo_factory=>client_repo( ).
  data saved type abap_bool value abap_false.
  while saved = abap_false.
    try.
        " Create the client
        data client type ref to /oop/cl_oauth_client.
        client = _create_client( name = name description = description company = company url = url ).
        " Save the client
        client_repo->create( client ).
      catch /oop/cx_oauth_record_exists.
        " Try again (new id and secret will be generated each time)
        continue.
    endtry.
    commit work.
    saved = abap_true.
  endwhile.
  " Return the client
  returning = client.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_AND_SAVE_TMP_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] CALLBACK                       TYPE        /OOP/OA_CALLBACK
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_and_save_tmp_token.
  " Create and save the temporary token into the database
  data tmp_token_repo type ref to /oop/if_oauth_tmp_token_repo.
  tmp_token_repo = /oop/cl_oauth_repo_factory=>tmp_token_repo( ).
  data saved type abap_bool value abap_false.
  while saved = abap_false.
    try.
        " Create the temporary token
        data tmp_token type ref to /oop/cl_oauth_tmp_token.
        tmp_token = _create_tmp_token( client_id = client_id callback = callback ).
        " Save the temporary token
        tmp_token_repo->create( tmp_token ).
      catch /oop/cx_oauth_record_exists.
        " Try again (new id and secret will be generated each time)
        continue.
    endtry.
    commit work.
    saved = abap_true.
  endwhile.
  " Return the temporary token
  returning = tmp_token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_AND_SAVE_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] USERNAME                       TYPE        XUBNAME
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_and_save_token.
  " Create and save the token into the database
  data token_repo type ref to /oop/if_oauth_token_repo.
  token_repo = /oop/cl_oauth_repo_factory=>token_repo( ).
  data saved type abap_bool value abap_false.
  while saved = abap_false.
    try.
        " Create the token
        data token type ref to /oop/cl_oauth_token.
        token = _create_token( client_id = client_id username = username ).
        " Save the token
        token_repo->create( token ).
      catch /oop/cx_oauth_record_exists.
        " Try again (new id and secret will be generated each time)
        continue.
    endtry.
    commit work.
    saved = abap_true.
  endwhile.
  " Return the token
  returning = token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_CLIENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_client.
  " Get a generated id for the client
  data id type /oop/oa_client_id.
  id = _oauth_util->new_client_id( ).
  " Get a generated secret for the client
  data secret type /oop/oa_client_secret.
  secret = _oauth_util->new_client_secret( ).
  " Create the client
  data client type ref to /oop/cl_oauth_client.
  create object client
    exporting
      id          = id
      secret      = secret
      name        = name
      description = description
      company     = company
      url         = url.
  " Return the client
  returning = client.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_TMP_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] CALLBACK                       TYPE        /OOP/OA_CALLBACK
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_tmp_token.
  " Get a generated id for the temporary token
  data token type /oop/oa_token.
  token = _oauth_util->new_token( ).
  " Get a generated secret for the temporary token
  data secret type /oop/oa_token_secret.
  secret = _oauth_util->new_token_secret( ).
  " Get a generated verifier for the temporary token
  data verifier type /oop/oa_verifier.
  verifier = _oauth_util->new_verifier( ).
  " Create the temporary token
  data tmp_token type ref to /oop/cl_oauth_tmp_token.
  create object tmp_token
    exporting
      client_id          = client_id
      token              = token
      secret             = secret
      verifier           = verifier
      authorized_by      = ``
      authenticity_token = ``
      callback           = callback.
  " Return the temporary token
  returning = tmp_token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_SERVICE->_CREATE_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] USERNAME                       TYPE        XUBNAME
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _create_token.
  " Get a generated id for the token
  data token type /oop/oa_token.
  token = _oauth_util->new_token( ).
  " Get a generated secret for the token
  data secret type /oop/oa_token_secret.
  secret = _oauth_util->new_token_secret( ).
  " Create the token
  data the_token type ref to /oop/cl_oauth_token.
  create object the_token
    exporting
      client_id = client_id
      token     = token
      secret    = secret
      username  = username.
  " Return the token
  returning = the_token.
endmethod.
ENDCLASS.
