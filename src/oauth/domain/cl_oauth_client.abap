class /OOP/CL_OAUTH_CLIENT definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_SERVICE
                 /OOP/IF_OAUTH_CLIENT_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_CLIENT
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !ID type /OOP/OA_CLIENT_ID
      !SECRET type /OOP/OA_CLIENT_SECRET
      !NAME type /OOP/OA_CLIENT_NAME
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION
      !COMPANY type /OOP/OA_CLIENT_COMPANY
      !URL type /OOP/OA_CLIENT_URL .
  methods ID
    returning
      value(RETURNING) type /OOP/OA_CLIENT_ID .
  methods SECRET
    returning
      value(RETURNING) type /OOP/OA_CLIENT_SECRET .
  methods NAME
    returning
      value(RETURNING) type /OOP/OA_CLIENT_NAME .
  methods DESCRIPTION
    returning
      value(RETURNING) type /OOP/OA_CLIENT_DESCRIPTION .
  methods COMPANY
    returning
      value(RETURNING) type /OOP/OA_CLIENT_COMPANY .
  methods URL
    returning
      value(RETURNING) type /OOP/OA_CLIENT_URL .
  methods SET_NAME
    importing
      !NAME type /OOP/OA_CLIENT_NAME .
  methods SET_DESCRIPTION
    importing
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION .
  methods SET_COMPANY
    importing
      !COMPANY type /OOP/OA_CLIENT_COMPANY .
  methods SET_URL
    importing
      !URL type /OOP/OA_CLIENT_URL .
protected section.
*"* protected components of class /OOP/CL_OAUTH_CLIENT
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_CLIENT
*"* do not include other source files here!!!

  data _ID type /OOP/OA_CLIENT_ID .
  data _SECRET type /OOP/OA_CLIENT_SECRET .
  data _NAME type /OOP/OA_CLIENT_NAME .
  data _DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION .
  data _COMPANY type /OOP/OA_CLIENT_COMPANY .
  data _URL type /OOP/OA_CLIENT_URL .

  methods _SET_ID
    importing
      !ID type /OOP/OA_CLIENT_ID .
  methods _SET_SECRET
    importing
      !SECRET type /OOP/OA_CLIENT_SECRET .
  methods _SET_NAME
    importing
      !NAME type /OOP/OA_CLIENT_NAME .
  methods _SET_DESCRIPTION
    importing
      !DESCRIPTION type /OOP/OA_CLIENT_DESCRIPTION .
  methods _SET_COMPANY
    importing
      !COMPANY type /OOP/OA_CLIENT_COMPANY .
  methods _SET_URL
    importing
      !URL type /OOP/OA_CLIENT_URL .
ENDCLASS.



CLASS /OOP/CL_OAUTH_CLIENT IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->COMPANY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_COMPANY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method company.
  returning = _company.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID                             TYPE        /OOP/OA_CLIENT_ID
* | [--->] SECRET                         TYPE        /OOP/OA_CLIENT_SECRET
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _set_id( id ).
  _set_secret( secret ).
  _set_name( name ).
  _set_description( description ).
  _set_company( company ).
  _set_url( url ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->DESCRIPTION
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_DESCRIPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method description.
  returning = _description.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method id.
  returning = _id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->NAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_NAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method name.
  returning = _name.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->SECRET
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method secret.
  returning = _secret.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->SET_COMPANY
* +-------------------------------------------------------------------------------------------------+
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method set_company.
  _set_company( company ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->SET_DESCRIPTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method set_description.
  _set_description( description ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->SET_NAME
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method set_name.
  _set_name( name ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->SET_URL
* +-------------------------------------------------------------------------------------------------+
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method set_url.
  _set_url( url ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT->URL
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method url.
  returning = _url.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_COMPANY
* +-------------------------------------------------------------------------------------------------+
* | [--->] COMPANY                        TYPE        /OOP/OA_CLIENT_COMPANY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_company.
  " todo: validate

  _company = company.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_DESCRIPTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] DESCRIPTION                    TYPE        /OOP/OA_CLIENT_DESCRIPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_description.
  " todo: validate

  _description = description.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID                             TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_id.
  _id = id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_NAME
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE        /OOP/OA_CLIENT_NAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_name.
  " todo: validate

  _name = name.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_SECRET
* +-------------------------------------------------------------------------------------------------+
* | [--->] SECRET                         TYPE        /OOP/OA_CLIENT_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_secret.
  _secret = secret.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_CLIENT->_SET_URL
* +-------------------------------------------------------------------------------------------------+
* | [--->] URL                            TYPE        /OOP/OA_CLIENT_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _set_url.
  " todo: validate

  _url = url.
endmethod.
ENDCLASS.
