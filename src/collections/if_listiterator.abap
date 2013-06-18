*"* components of interface /OOP/IF_LISTITERATOR
interface /OOP/IF_LISTITERATOR
  public .


  interfaces /OOP/IF_ITERATOR .

  aliases HASNEXT
    for /OOP/IF_ITERATOR~HASNEXT .
  aliases NEXT
    for /OOP/IF_ITERATOR~NEXT .
  aliases REMOVE
    for /OOP/IF_ITERATOR~REMOVE .

  methods ADD
    importing
      !ELEMENT type ref to /OOP/CL_OBJECT .
  type-pools ABAP .
  methods HASPREVIOUS
    returning
      value(RETURNING) type ABAP_BOOL .
  methods NEXTINDEX
    returning
      value(RETURNING) type I .
  methods PREVIOUS
    returning
      value(RETURNING) type ref to /OOP/CL_OBJECT .
  methods PREVIOUSINDEX
    returning
      value(RETURNING) type I .
  methods SET
    importing
      !ELEMENT type ref to /OOP/CL_OBJECT .
endinterface.
