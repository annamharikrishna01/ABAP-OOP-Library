class /OOP/CL_JSON_NULL definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_JSON_NULL
*"* do not include other source files here!!!

  interfaces /OOP/IF_JSON_VALUE .
protected section.
*"* protected components of class /OOP/CL_JSON_NULL
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_JSON_NULL
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_JSON_NULL IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_NULL->/OOP/IF_JSON_VALUE~GET_TYPE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_json_value~get_type.
  returning = /oop/cl_json_types=>type_null.
endmethod.
ENDCLASS.
