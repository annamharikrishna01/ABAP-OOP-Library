class /OOP/CL_JSON_BOOLEAN definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_JSON_BOOLEAN
*"* do not include other source files here!!!
  type-pools ABAP .

  interfaces /OOP/IF_JSON_VALUE .

  aliases GET_TYPE
    for /OOP/IF_JSON_VALUE~GET_TYPE .

  data VALUE type ABAP_BOOL read-only .

  methods CONSTRUCTOR
    importing
      !VALUE type ABAP_BOOL .
protected section.
*"* protected components of class /OOP/CL_JSON_BOOLEAN
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_JSON_BOOLEAN
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_JSON_BOOLEAN IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_BOOLEAN->/OOP/IF_JSON_VALUE~GET_TYPE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_json_value~get_type.
  returning = /oop/cl_json_types=>type_boolean.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_JSON_BOOLEAN->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] VALUE                          TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  me->value = value.
endmethod.
ENDCLASS.
