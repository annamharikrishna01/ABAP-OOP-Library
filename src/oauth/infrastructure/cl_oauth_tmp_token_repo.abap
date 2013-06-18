class /OOP/CL_OAUTH_TMP_TOKEN_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_TMP_TOKEN_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_TMP_TOKEN_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_TOKEN_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TMP_TOKEN_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_TOKEN_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN_REPO->/OOP/IF_OAUTH_TMP_TOKEN_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] TMP_TOKEN                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_token_repo~create.
  data oa_tmp_toke_record type /oop/oa_tmp_toke.
  oa_tmp_toke_record-token = tmp_token->token( ).
  oa_tmp_toke_record-secret = tmp_token->secret( ).
  oa_tmp_toke_record-verifier = tmp_token->verifier( ).
  oa_tmp_toke_record-client_id = tmp_token->client_id( ).
  oa_tmp_toke_record-callback = tmp_token->callback( ).
  get time stamp field oa_tmp_toke_record-created_at.
  oa_tmp_toke_record-created_by = sy-uname.
  insert /oop/oa_tmp_toke from oa_tmp_toke_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN_REPO->/OOP/IF_OAUTH_TMP_TOKEN_REPO~DELETE
* +-------------------------------------------------------------------------------------------------+
* | [--->] TMP_TOKEN                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_token_repo~delete.
  data token type /oop/oa_token.
  token = tmp_token->token( ).
  delete from /oop/oa_tmp_toke where token = token.
  if sy-subrc <> 0.
    " Nothing to delete - this shouldn't happen, but is not a problem at this point if it does
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN_REPO->/OOP/IF_OAUTH_TMP_TOKEN_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_token_repo~find_by_id.
  data oa_tmp_toke_record type /oop/oa_tmp_toke.
  select single * from /oop/oa_tmp_toke into oa_tmp_toke_record
    where token = token.
  if sy-subrc = 0.
    data thetoken type ref to /oop/cl_oauth_tmp_token.
    create object thetoken
      exporting
        client_id          = oa_tmp_toke_record-client_id
        token              = oa_tmp_toke_record-token
        secret             = oa_tmp_toke_record-secret
        verifier           = oa_tmp_toke_record-verifier
        callback           = oa_tmp_toke_record-callback
        authorized_by      = oa_tmp_toke_record-authorized_by
        authenticity_token = oa_tmp_toke_record-authenticity_tok.
    returning = thetoken.
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN_REPO->/OOP/IF_OAUTH_TMP_TOKEN_REPO~UPDATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] TMP_TOKEN                      TYPE REF TO /OOP/CL_OAUTH_TMP_TOKEN
* | [!CX!] /OOP/CX_OAUTH_RECORD_NOT_FOUND
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_token_repo~update.
  data token type /oop/oa_token.
  token = tmp_token->token( ).
  data authorized_by type xubname.
  authorized_by = tmp_token->_authorized_by.
  data authenticity_token type /oop/oa_authenticity_token.
  authenticity_token = tmp_token->authenticity_token( ).
  update /oop/oa_tmp_toke
    set authorized_by = authorized_by authenticity_tok = authenticity_token
    where token = token.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_not_found.
  endif.
endmethod.
ENDCLASS.
