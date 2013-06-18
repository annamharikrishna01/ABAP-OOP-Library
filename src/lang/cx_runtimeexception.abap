class /OOP/CX_RUNTIMEEXCEPTION definition
  public
  inheriting from CX_NO_CHECK
  create public .

public section.
*"* public components of class /OOP/CX_RUNTIMEEXCEPTION
*"* do not include other source files here!!!

  constants /OOP/CX_RUNTIMEEXCEPTION type SOTR_CONC value '001560AB31521EE1B6FDF852B7FA5160'. "#EC NOTEXT
  data MESSAGE type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE type STRING optional .
protected section.
*"* protected components of class /OOP/CX_RUNTIMEEXCEPTION
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CX_RUNTIMEEXCEPTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CX_RUNTIMEEXCEPTION IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CX_RUNTIMEEXCEPTION->CONSTRUCTOR
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
   me->textid = /OOP/CX_RUNTIMEEXCEPTION .
 ENDIF.
me->MESSAGE = MESSAGE .
endmethod.
ENDCLASS.
