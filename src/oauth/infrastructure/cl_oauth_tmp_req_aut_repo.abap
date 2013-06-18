class /OOP/CL_OAUTH_TMP_REQ_AUT_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_TMP_REQ_AUT_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_TMP_REQ_AUT_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_REQ_AUT_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TMP_REQ_AUT_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_REQ_AUT_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT_REPO->/OOP/IF_OAUTH_TMP_REQ_AUT_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/CL_OAUTH_TMP_REQ_AUT
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_req_aut_repo~create.
  data oa_tmp_auth_record type /oop/oa_tmp_auth.
  oa_tmp_auth_record-consumer_key = request->consumer_key( ).
  oa_tmp_auth_record-timestamp = request->timestamp( ).
  oa_tmp_auth_record-nonce = request->nonce( ).
  oa_tmp_auth_record-signature = request->signature( ).
  oa_tmp_auth_record-signature_method = request->signature_method( ).
  oa_tmp_auth_record-token = request->token( ).
  oa_tmp_auth_record-verifier = request->verifier( ).
  oa_tmp_auth_record-version = request->version( ).
  get time stamp field oa_tmp_auth_record-created_at.
  oa_tmp_auth_record-created_by = sy-uname.
  insert /oop/oa_tmp_auth from oa_tmp_auth_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT_REPO->/OOP/IF_OAUTH_TMP_REQ_AUT_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_REQ_AUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_req_aut_repo~find_by_id.
  data oa_tmp_auth_record type /oop/oa_tmp_auth.
  select single * from /oop/oa_tmp_auth into oa_tmp_auth_record
    where consumer_key = consumer_key and timestamp = timestamp and nonce = nonce.
  if sy-subrc = 0.
    data request type ref to /oop/cl_oauth_tmp_req_aut.
    create object request
      exporting
        consumer_key     = oa_tmp_auth_record-consumer_key
        timestamp        = oa_tmp_auth_record-timestamp
        nonce            = oa_tmp_auth_record-nonce
        signature        = oa_tmp_auth_record-signature
        signature_method = oa_tmp_auth_record-signature_method
        token            = oa_tmp_auth_record-token
        verifier         = oa_tmp_auth_record-verifier
        version          = oa_tmp_auth_record-version.
    returning = request.
    return.
  endif.
endmethod.
ENDCLASS.
