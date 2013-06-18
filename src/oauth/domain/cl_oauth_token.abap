class /OOP/CL_OAUTH_TOKEN definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_SERVICE
                 /OOP/IF_OAUTH_TOKEN_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_TOKEN
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !TOKEN type /OOP/OA_TOKEN
      !SECRET type /OOP/OA_TOKEN_SECRET
      !USERNAME type /OOP/OA_USERNAME .
  methods CLIENT_ID
    returning
      value(RETURNING) type /OOP/OA_CLIENT_ID .
  methods TOKEN
    returning
      value(RETURNING) type /OOP/OA_TOKEN .
  methods SECRET
    returning
      value(RETURNING) type /OOP/OA_TOKEN_SECRET .
  methods USERNAME
    returning
      value(RETURNING) type /OOP/OA_USERNAME .
protected section.
*"* protected components of class /OOP/CL_OAUTH_TOKEN
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_TOKEN
*"* do not include other source files here!!!

  data _CLIENT_ID type /OOP/OA_CLIENT_ID .
  data _TOKEN type /OOP/OA_TOKEN .
  data _SECRET type /OOP/OA_TOKEN_SECRET .
  data _USERNAME type /OOP/OA_USERNAME .
ENDCLASS.



CLASS /OOP/CL_OAUTH_TOKEN IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN->CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method client_id.
  returning = _client_id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] TOKEN                          TYPE        /OOP/OA_TOKEN
* | [--->] SECRET                         TYPE        /OOP/OA_TOKEN_SECRET
* | [--->] USERNAME                       TYPE        /OOP/OA_USERNAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _client_id = client_id.
  _token = token.
  _secret = secret.
  _username = username.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN->SECRET
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method secret.
  returning = _secret.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN->TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token.
  returning = _token.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_TOKEN->USERNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_USERNAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method username.
  returning = _username.
endmethod.
ENDCLASS.
