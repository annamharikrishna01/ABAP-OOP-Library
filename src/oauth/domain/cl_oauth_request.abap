class /OOP/CL_OAUTH_REQUEST definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public

  global friends /OOP/IF_OAUTH_REQUEST_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_REQUEST
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !CONSUMER_KEY type /OOP/OA_CONSUMER_KEY
      !TIMESTAMP type /OOP/OA_TIMESTAMP
      !NONCE type /OOP/OA_NONCE
      !SIGNATURE type /OOP/OA_SIGNATURE
      !SIGNATURE_METHOD type /OOP/OA_SIGNATURE_METHOD
      !TOKEN type /OOP/OA_TOKEN
      !VERSION type /OOP/OA_VERSION
      !BASE_STRING type STRING .
  methods CONSUMER_KEY
    returning
      value(RETURNING) type /OOP/OA_CONSUMER_KEY .
  methods TIMESTAMP
    returning
      value(RETURNING) type /OOP/OA_TIMESTAMP .
  methods NONCE
    returning
      value(RETURNING) type /OOP/OA_NONCE .
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
  methods BASE_STRING
    returning
      value(RETURNING) type STRING .
  methods AUTHORIZE .
  methods IS_AUTHORIZED
    returning
      value(RETURNING) type /OOP/OA_AUTHORIZED .
  protected section.
*"* protected components of class /OOP/CL_OAUTH_REQUEST
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_REQUEST
*"* do not include other source files here!!!

  data _CONSUMER_KEY type /OOP/OA_CONSUMER_KEY .
  data _TIMESTAMP type /OOP/OA_TIMESTAMP .
  data _NONCE type /OOP/OA_NONCE .
  data _SIGNATURE type /OOP/OA_SIGNATURE .
  data _SIGNATURE_METHOD type /OOP/OA_SIGNATURE_METHOD .
  data _TOKEN type /OOP/OA_TOKEN .
  data _VERSION type /OOP/OA_VERSION .
  data _BASE_STRING type STRING .
  data _AUTHORIZED type /OOP/OA_AUTHORIZED .
ENDCLASS.



CLASS /OOP/CL_OAUTH_REQUEST IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->AUTHORIZE
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method authorize.
  _authorized = abap_true.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->BASE_STRING
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method base_string.
  returning = _base_string.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONSUMER_KEY                   TYPE        /OOP/OA_CONSUMER_KEY
* | [--->] TIMESTAMP                      TYPE        /OOP/OA_TIMESTAMP
* | [--->] NONCE                          TYPE        /OOP/OA_NONCE
* | [--->] SIGNATURE                      TYPE        /OOP/OA_SIGNATURE
* | [--->] SIGNATURE_METHOD               TYPE        /OOP/OA_SIGNATURE_METHOD
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [--->] VERSION                        TYPE        /OOP/OA_VERSION
* | [--->] BASE_STRING                    TYPE        STRING
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
  _base_string = base_string.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->CONSUMER_KEY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CONSUMER_KEY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method consumer_key.
  returning = _consumer_key.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->IS_AUTHORIZED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_AUTHORIZED
* +--------------------------------------------------------------------------------------</SIGNATURE>
method is_authorized.
  returning = _authorized.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->NONCE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_NONCE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method nonce.
  returning = _nonce.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->SIGNATURE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature.
  returning = _signature.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->SIGNATURE_METHOD
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE_METHOD
* +--------------------------------------------------------------------------------------</SIGNATURE>
method signature_method.
  returning = _signature_method.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->TIMESTAMP
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TIMESTAMP
* +--------------------------------------------------------------------------------------</SIGNATURE>
method timestamp.
  returning = _timestamp.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token.
  returning = _token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_REQUEST->VERSION
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERSION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method version.
  returning = _version.
endmethod.
ENDCLASS.
