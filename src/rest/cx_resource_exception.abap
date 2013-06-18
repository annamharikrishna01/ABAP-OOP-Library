class /OOP/CX_RESOURCE_EXCEPTION definition
  public
  inheriting from /OOP/CX_STATICEXCEPTION
  final
  create public .

public section.
*"* public components of class /OOP/CX_RESOURCE_EXCEPTION
*"* do not include other source files here!!!

  constants /OOP/CX_RESOURCE_EXCEPTION type SOTR_CONC value '001560AB31521EE1B6FF84CDF983B160'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE type STRING optional .
protected section.
*"* protected components of class /OOP/CX_RESOURCE_EXCEPTION
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CX_RESOURCE_EXCEPTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CX_RESOURCE_EXCEPTION IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CX_RESOURCE_EXCEPTION->CONSTRUCTOR
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
   me->textid = /OOP/CX_RESOURCE_EXCEPTION .
 ENDIF.
endmethod.
ENDCLASS.
