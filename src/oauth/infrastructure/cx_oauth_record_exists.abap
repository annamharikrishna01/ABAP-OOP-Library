class /OOP/CX_OAUTH_RECORD_EXISTS definition
  public
  inheriting from /OOP/CX_STATICEXCEPTION
  final
  create public .

public section.
*"* public components of class /OOP/CX_OAUTH_RECORD_EXISTS
*"* do not include other source files here!!!

  constants /OOP/CX_OAUTH_RECORD_EXISTS type SOTR_CONC value '001560AB31521EE292BEC2D848853972'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE type STRING optional .
protected section.
*"* protected components of class /OOP/CX_OAUTH_RECORD_EXISTS
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CX_OAUTH_RECORD_EXISTS
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CX_OAUTH_RECORD_EXISTS IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CX_OAUTH_RECORD_EXISTS->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] TEXTID                         LIKE        TEXTID(optional)
* | [--->] PREVIOUS                       LIKE        PREVIOUS(optional)
* | [--->] MESSAGE                        TYPE        STRING(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
MESSAGE = MESSAGE
.
 IF textid IS INITIAL.
   me->textid = /OOP/CX_OAUTH_RECORD_EXISTS .
 ENDIF.
endmethod.
ENDCLASS.
