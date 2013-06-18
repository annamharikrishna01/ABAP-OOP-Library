class /OOP/CL_JSON_STRING definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_JSON_STRING
*"* do not include other source files here!!!

  interfaces /OOP/IF_JSON_VALUE .

  aliases GET_TYPE
    for /OOP/IF_JSON_VALUE~GET_TYPE .

  data VALUE type STRING read-only .

  methods CONSTRUCTOR
    importing
      !VALUE type STRING .
protected section.
*"* protected components of class /OOP/CL_JSON_STRING
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_JSON_STRING
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_JSON_STRING IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_STRING->/OOP/IF_JSON_VALUE~GET_TYPE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_json_value~get_type.
  returning = /oop/cl_json_types=>type_string.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_STRING->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] VALUE                          TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  me->value = value.
endmethod.
ENDCLASS.
