class /OOP/CL_COLLECTIONS definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private .

public section.
*"* public components of class /OOP/CL_COLLECTIONS
*"* do not include other source files here!!!

  class-methods UNMODIFIABLELIST
    importing
      !LIST type ref to /OOP/IF_LIST
    returning
      value(RETURNING) type ref to /OOP/IF_LIST .
protected section.
*"* protected components of class /OOP/CL_COLLECTIONS
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_COLLECTIONS
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_COLLECTIONS IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_COLLECTIONS=>UNMODIFIABLELIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] LIST                           TYPE REF TO /OOP/IF_LIST
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_LIST
* +--------------------------------------------------------------------------------------</SIGNATURE>
method unmodifiablelist.
  data unmodifiablelist type ref to lcl_unmodifiablelist.
  create object unmodifiablelist
    exporting
      list = list.
  returning = unmodifiablelist.
endmethod.
ENDCLASS.
