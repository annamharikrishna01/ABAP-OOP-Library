class /OOP/CL_OAUTH_TMP_TOKEN definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_SERVICE
                 /OOP/IF_OAUTH_TMP_TOKEN_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_TMP_TOKEN
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !TOKEN type /OOP/OA_TOKEN
      !SECRET type /OOP/OA_TOKEN_SECRET
      !VERIFIER type /OOP/OA_VERIFIER
      !AUTHORIZED_BY type /OOP/OA_USERNAME
      !AUTHENTICITY_TOKEN type /OOP/OA_AUTHENTICITY_TOKEN
      !CALLBACK type /OOP/OA_CALLBACK .
  methods CLIENT_ID
    returning
      value(RETURNING) type /OOP/OA_CLIENT_ID .
  methods TOKEN
    returning
      value(RETURNING) type /OOP/OA_TOKEN .
  methods SECRET
    returning
      value(RETURNING) type /OOP/OA_TOKEN_SECRET .
  methods VERIFIER
    returning
      value(RETURNING) type /OOP/OA_VERIFIER .
  methods AUTHORIZE .
  methods AUTHORIZED_BY
    returning
      value(RETURNING) type /OOP/OA_USERNAME .
  methods AUTHENTICITY_TOKEN
    returning
      value(RETURNING) type /OOP/OA_AUTHENTICITY_TOKEN .
  methods SET_AUTHENTICITY_TOKEN
    importing
      !AUTHENTICITY_TOKEN type /OOP/OA_AUTHENTICITY_TOKEN .
  methods CALLBACK
    returning
      value(RETURNING) type /OOP/OA_CALLBACK .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TMP_TOKEN
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TMP_TOKEN
*"* do not include other source files here!!!

  data _CLIENT_ID type /OOP/OA_CLIENT_ID .
  data _TOKEN type /OOP/OA_TOKEN .
  data _SECRET type /OOP/OA_TOKEN_SECRET .
  data _VERIFIER type /OOP/OA_VERIFIER .
  data _AUTHORIZED_BY type /OOP/OA_USERNAME .
  data _AUTHENTICITY_TOKEN type /OOP/OA_AUTHENTICITY_TOKEN .
  data _CALLBACK type /OOP/OA_CALLBACK .
ENDCLASS.



CLASS /OOP/CL_OAUTH_TMP_TOKEN IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->AUTHENTICITY_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_AUTHENTICITY_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method authenticity_token.
  returning = _authenticity_token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->AUTHORIZE
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method authorize.
  _authorized_by = sy-uname.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->AUTHORIZED_BY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_USERNAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method authorized_by.
  returning = _authorized_by.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->CALLBACK
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CALLBACK
* +--------------------------------------------------------------------------------------</SIGNATURE>
method callback.
  returning = _callback.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method client_id.
  returning = _client_id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [--->] SECRET                         TYPE        /OOP/OA_TOKEN_SECRET
* | [--->] VERIFIER                       TYPE        /OOP/OA_VERIFIER
* | [--->] AUTHORIZED_BY                  TYPE        /OOP/OA_USERNAME
* | [--->] AUTHENTICITY_TOKEN             TYPE        /OOP/OA_AUTHENTICITY_TOKEN
* | [--->] CALLBACK                       TYPE        /OOP/OA_CALLBACK
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _client_id = client_id.
  _token = token.
  _secret = secret.
  _verifier = verifier.
  _authorized_by = authorized_by.
  _authenticity_token = authenticity_token.
  _callback = callback.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->SECRET
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method secret.
  returning = _secret.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->SET_AUTHENTICITY_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] AUTHENTICITY_TOKEN             TYPE        /OOP/OA_AUTHENTICITY_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method set_authenticity_token.
  _authenticity_token = authenticity_token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token.
  returning = _token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TMP_TOKEN->VERIFIER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERIFIER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method verifier.
  returning = _verifier.
endmethod.
ENDCLASS.
