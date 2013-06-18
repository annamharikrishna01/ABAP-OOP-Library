class /OOP/CX_STATICEXCEPTION definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.
*"* public components of class /OOP/CX_STATICEXCEPTION
*"* do not include other source files here!!!

  constants /OOP/CX_STATICEXCEPTION type SOTR_CONC value '001560AB31521EE1B6FDFD8FEFDED160'. "#EC NOTEXT
  data MESSAGE type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE type STRING optional .
protected section.
*"* protected components of class /OOP/CX_STATICEXCEPTION
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CX_STATICEXCEPTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CX_STATICEXCEPTION IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CX_STATICEXCEPTION->CONSTRUCTOR
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
.
 IF textid IS INITIAL.
   me->textid = /OOP/CX_STATICEXCEPTION .
 ENDIF.
me->MESSAGE = MESSAGE .
endmethod.
ENDCLASS.
