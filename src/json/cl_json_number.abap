class /OOP/CL_JSON_NUMBER definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_JSON_NUMBER
*"* do not include other source files here!!!

  interfaces /OOP/IF_JSON_VALUE .

  aliases GET_TYPE
    for /OOP/IF_JSON_VALUE~GET_TYPE .

  data VALUE type F read-only .

  methods CONSTRUCTOR
    importing
      !VALUE type F .
protected section.
*"* protected components of class /OOP/CL_JSON_NUMBER
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_JSON_NUMBER
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_JSON_NUMBER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_NUMBER->/OOP/IF_JSON_VALUE~GET_TYPE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_json_value~get_type.
  returning = /oop/cl_json_types=>type_number.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_NUMBER->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] VALUE                          TYPE        F
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  me->value = value.
endmethod.
ENDCLASS.
