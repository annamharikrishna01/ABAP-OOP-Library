class /OOP/CL_OAUTH_REQUEST_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_REQUEST_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_REQUEST_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_REQUEST_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_REQUEST_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_REQUEST_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST_REPO->/OOP/IF_OAUTH_REQUEST_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/CL_OAUTH_REQUEST
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_request_repo~create.
  data oa_requests_record type /oop/oa_requests.
  oa_requests_record-consumer_key = request->consumer_key( ).
  oa_requests_record-timestamp = request->timestamp( ).
  oa_requests_record-nonce = request->nonce( ).
  oa_requests_record-signature = request->signature( ).
  oa_requests_record-signature_method = request->signature_method( ).
  oa_requests_record-token = request->token( ).
  oa_requests_record-version = request->version( ).
  oa_requests_record-base_string = request->base_string( ).
  oa_requests_record-authorized = request->is_authorized( ).
  get time stamp field oa_requests_record-created_at.
  oa_requests_record-created_by = sy-uname.
  insert /oop/oa_requests from oa_requests_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST_REPO->/OOP/IF_OAUTH_REQUEST_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_REQUEST
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_request_repo~find_by_id.
  data oa_requests_record type /oop/oa_requests.
  select single * from /oop/oa_requests into oa_requests_record
    where consumer_key = consumer_key and timestamp = timestamp and nonce = nonce.
  if sy-subrc = 0.
    data request type ref to /oop/cl_oauth_request.
    create object request
      exporting
        consumer_key     = oa_requests_record-consumer_key
        timestamp        = oa_requests_record-timestamp
        nonce            = oa_requests_record-nonce
        signature        = oa_requests_record-signature
        signature_method = oa_requests_record-signature_method
        token            = oa_requests_record-token
        version          = oa_requests_record-version
        base_string      = oa_requests_record-base_string.
    returning = request.
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST_REPO->/OOP/IF_OAUTH_REQUEST_REPO~UPDATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/CL_OAUTH_REQUEST
* | [!CX!] /OOP/CX_OAUTH_RECORD_NOT_FOUND
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_request_repo~update.
  data consumer_key type /oop/oa_consumer_key.
  consumer_key = request->consumer_key( ).
  data timestamp type /oop/oa_timestamp.
  timestamp = request->timestamp( ).
  data nonce type /oop/oa_nonce.
  nonce = request->nonce( ).
  data authorized type /oop/oa_authorized.
  authorized = request->is_authorized( ).
  update /oop/oa_requests
    set authorized = authorized
    where consumer_key = consumer_key and
          timestamp = timestamp and
          nonce = nonce.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_not_found.
  endif.
endmethod.
ENDCLASS.
