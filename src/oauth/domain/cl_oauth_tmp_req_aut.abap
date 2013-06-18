class /oop/cl_oauth_tmp_req_aut definition
  public
  inheriting from /oop/cl_object
  final
  create public

  global friends /oop/if_oauth_tmp_req_aut_repo .

  public section.
*"* public components of class /OOP/CL_OAUTH_TMP_REQ_AUT
*"* do not include other source files here!!!

    methods constructor
      importing
        !consumer_key type /oop/oa_consumer_key
        !timestamp type /oop/oa_timestamp
        !nonce type /oop/oa_nonce
        !signature type /oop/oa_signature
        !signature_method type /oop/oa_signature_method
        !token type /oop/oa_token
        !version type /oop/oa_version
        !verifier type /oop/oa_verifier.
    methods consumer_key
      returning
        value(returning) type /oop/oa_consumer_key .
    methods timestamp
      returning
        value(returning) type /oop/oa_timestamp .
    methods nonce
      returning
        value(returning) type /oop/oa_nonce .
    methods signature
      returning
        value(returning) type /oop/oa_signature .
    methods signature_method
      returning
        value(returning) type /oop/oa_signature_method .
    methods token
      returning
        value(returning) type /oop/oa_token .
    methods verifier
      returning
        value(returning) type /oop/oa_verifier .
    methods version
      returning
        value(returning) type /oop/oa_version .
  protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_REQ_AUT
*"* do not include other source files here!!!
  private section.
*"* private components of class /OOP/CL_OAUTH_TMP_REQ_AUT
*"* do not include other source files here!!!

    data _consumer_key type /oop/oa_consumer_key .
    data _timestamp type /oop/oa_timestamp .
    data _nonce type /oop/oa_nonce .
    data _signature type /oop/oa_signature .
    data _signature_method type /oop/oa_signature_method .
    data _token type /oop/oa_token .
    data _verifier type /oop/oa_verifier .
    data _version type /oop/oa_version .
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_REQ_AUT IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [--->] SIGNATURE                      TYPE        /OOP/OA_SIGNATURE
* | [--->] SIGNATURE_METHOD               TYPE        /OOP/OA_SIGNATURE_METHOD
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [--->] VERSION                        TYPE        /OOP/OA_VERSION
* | [--->] VERIFIER                       TYPE        /OOP/OA_VERIFIER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _consumer_key = consumer_key.
  _timestamp = timestamp.
  _nonce = nonce.
  _signature = signature.
  _signature_method = signature_method.
  _token = token.
  _version = version.
  _verifier = verifier.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->CONSUMER_KEY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CONSUMER_KEY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method consumer_key.
  returning = _consumer_key.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->NONCE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_NONCE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method nonce.
  returning = _nonce.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->SIGNATURE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature.
  returning = _signature.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->SIGNATURE_METHOD
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE_METHOD
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature_method.
  returning = _signature_method.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->TIMESTAMP
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TIMESTAMP
* +--------------------------------------------------------------------------------------</SIGNATURE>
method timestamp.
  returning = _timestamp.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token.
  returning = _token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->VERIFIER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERIFIER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method verifier.
  returning = _verifier.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_AUT->VERSION
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERSION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method version.
  returning = _version.
endmethod.
ENDCLASS.
