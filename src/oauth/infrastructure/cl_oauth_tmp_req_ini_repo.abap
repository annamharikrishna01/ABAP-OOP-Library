class /OOP/CL_OAUTH_TMP_REQ_INI_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_TMP_REQ_INI_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_TMP_REQ_INI_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_REQ_INI_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TMP_REQ_INI_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_REQ_INI_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI_REPO->/OOP/IF_OAUTH_TMP_REQ_INI_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/CL_OAUTH_TMP_REQ_INI
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_req_ini_repo~create.
  data oa_tmp_init_record type /oop/oa_tmp_init.
  oa_tmp_init_record-consumer_key = request->consumer_key( ).
  oa_tmp_init_record-timestamp = request->timestamp( ).
  oa_tmp_init_record-nonce = request->nonce( ).
  oa_tmp_init_record-callback = request->callback( ).
  oa_tmp_init_record-signature = request->signature( ).
  oa_tmp_init_record-signature_method = request->signature_method( ).
  oa_tmp_init_record-token = request->token( ).
  oa_tmp_init_record-version = request->version( ).
  get time stamp field oa_tmp_init_record-created_at.
  oa_tmp_init_record-created_by = sy-uname.
  insert /oop/oa_tmp_init from oa_tmp_init_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI_REPO->/OOP/IF_OAUTH_TMP_REQ_INI_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_TMP_REQ_INI
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_tmp_req_ini_repo~find_by_id.
  data oa_tmp_init_record type /oop/oa_tmp_init.
  select single * from /oop/oa_tmp_init into oa_tmp_init_record
    where consumer_key = consumer_key and timestamp = timestamp and nonce = nonce.
  if sy-subrc = 0.
    data request type ref to /oop/cl_oauth_tmp_req_ini.
    create object request
      exporting
        consumer_key     = oa_tmp_init_record-consumer_key
        timestamp        = oa_tmp_init_record-timestamp
        callback         = oa_tmp_init_record-callback
        nonce            = oa_tmp_init_record-nonce
        signature        = oa_tmp_init_record-signature
        signature_method = oa_tmp_init_record-signature_method
        token            = oa_tmp_init_record-token
        version          = oa_tmp_init_record-version.
    returning = request.
    return.
  endif.
endmethod.
ENDCLASS.
