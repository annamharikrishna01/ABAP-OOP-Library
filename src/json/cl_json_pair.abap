class /OOP/CL_JSON_PAIR definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_JSON_PAIR
*"* do not include other source files here!!!

  data NAME type ref to /OOP/CL_JSON_STRING read-only .
  data VALUE type ref to /OOP/IF_JSON_VALUE read-only .

  methods CONSTRUCTOR
    importing
      !NAME type ref to /OOP/CL_JSON_STRING
      !VALUE type ref to /OOP/IF_JSON_VALUE .
protected section.
*"* protected components of class /OOP/CL_JSON_PAIR
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_JSON_PAIR
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_JSON_PAIR IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_PAIR->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAME                           TYPE REF TO /OOP/CL_JSON_STRING
* | [--->] VALUE                          TYPE REF TO /OOP/IF_JSON_VALUE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  me->name = name.
  me->value = value.
endmethod.
ENDCLASS.
