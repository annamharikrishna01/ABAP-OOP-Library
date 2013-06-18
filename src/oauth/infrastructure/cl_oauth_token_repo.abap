class /OOP/CL_OAUTH_TOKEN_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_TOKEN_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_TOKEN_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TOKEN_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TOKEN_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_TOKEN_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN_REPO->/OOP/IF_OAUTH_TOKEN_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] TOKEN                          TYPE REF TO /OOP/CL_OAUTH_TOKEN
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_token_repo~create.
  data oa_tokens_record type /oop/oa_tokens.
  oa_tokens_record-token = token->token( ).
  oa_tokens_record-secret = token->secret( ).
  oa_tokens_record-username = token->username( ).
  oa_tokens_record-client_id = token->client_id( ).
  get time stamp field oa_tokens_record-created_at.
  oa_tokens_record-created_by = sy-uname.
  insert /oop/oa_tokens from oa_tokens_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN_REPO->/OOP/IF_OAUTH_TOKEN_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_token_repo~find_by_id.
  data oa_tokens_record type /oop/oa_tokens.
  select single * from /oop/oa_tokens into oa_tokens_record
    where token = token.
  if sy-subrc = 0.
    " Update last access
    get time stamp field oa_tokens_record-last_access_at.
    oa_tokens_record-last_access_by = sy-uname.
    update /oop/oa_tokens
      set last_access_at = oa_tokens_record-last_access_at
          last_access_by = oa_tokens_record-last_access_by
      where token = oa_tokens_record-token.
    if sy-subrc = 0.
      commit work.
    endif.
    " Return the token
    data the_token type ref to /oop/cl_oauth_token.
    create object the_token
      exporting
        client_id = oa_tokens_record-client_id
        token     = oa_tokens_record-token
        secret    = oa_tokens_record-secret
        username  = oa_tokens_record-username.
    returning = the_token.
    return.
  endif.
endmethod.
ENDCLASS.
