class /OOP/CL_OAUTH_TMP_REQ_INI definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public

  global friends /OOP/IF_OAUTH_TMP_REQ_INI_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_TMP_REQ_INI
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !CONSUMER_KEY type /OOP/OA_CONSUMER_KEY
      !TIMESTAMP type /OOP/OA_TIMESTAMP
      !NONCE type /OOP/OA_NONCE
      !CALLBACK type /OOP/OA_CALLBACK
      !SIGNATURE type /OOP/OA_SIGNATURE
      !SIGNATURE_METHOD type /OOP/OA_SIGNATURE_METHOD
      !TOKEN type /OOP/OA_TOKEN
      !VERSION type /OOP/OA_VERSION .
  methods CONSUMER_KEY
    returning
      value(RETURNING) type /OOP/OA_CONSUMER_KEY .
  methods TIMESTAMP
    returning
      value(RETURNING) type /OOP/OA_TIMESTAMP .
  methods NONCE
    returning
      value(RETURNING) type /OOP/OA_NONCE .
  methods CALLBACK
    returning
      value(RETURNING) type /OOP/OA_VERIFIER .
  methods SIGNATURE
    returning
      value(RETURNING) type /OOP/OA_SIGNATURE .
  methods SIGNATURE_METHOD
    returning
      value(RETURNING) type /OOP/OA_SIGNATURE_METHOD .
  methods TOKEN
    returning
      value(RETURNING) type /OOP/OA_TOKEN .
  methods VERSION
    returning
      value(RETURNING) type /OOP/OA_VERSION .
  protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_REQ_AUT
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TMP_REQ_INI
*"* do not include other source files here!!!

  data _CONSUMER_KEY type /OOP/OA_CONSUMER_KEY .
  data _TIMESTAMP type /OOP/OA_TIMESTAMP .
  data _NONCE type /OOP/OA_NONCE .
  data _CALLBACK type /OOP/OA_CALLBACK .
  data _SIGNATURE type /OOP/OA_SIGNATURE .
  data _SIGNATURE_METHOD type /OOP/OA_SIGNATURE_METHOD .
  data _TOKEN type /OOP/OA_TOKEN .
  data _VERSION type /OOP/OA_VERSION .
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_REQ_INI IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->CALLBACK
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERIFIER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method callback.
  returning = _callback.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [--->] CALLBACK                       TYPE        /OOP/OA_CALLBACK
* | [--->] SIGNATURE                      TYPE        /OOP/OA_SIGNATURE
* | [--->] SIGNATURE_METHOD               TYPE        /OOP/OA_SIGNATURE_METHOD
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [--->] VERSION                        TYPE        /OOP/OA_VERSION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _consumer_key = consumer_key.
  _timestamp = timestamp.
  _nonce = nonce.
  _callback = callback.
  _signature = signature.
  _signature_method = signature_method.
  _token = token.
  _version = version.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->CONSUMER_KEY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CONSUMER_KEY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method consumer_key.
  returning = _consumer_key.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->NONCE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_NONCE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method nonce.
  returning = _nonce.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->SIGNATURE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature.
  returning = _signature.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->SIGNATURE_METHOD
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE_METHOD
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature_method.
  returning = _signature_method.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->TIMESTAMP
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TIMESTAMP
* +--------------------------------------------------------------------------------------</SIGNATURE>
method timestamp.
  returning = _timestamp.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token.
  returning = _token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_REQ_INI->VERSION
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERSION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method version.
  returning = _version.
endmethod.
ENDCLASS.
