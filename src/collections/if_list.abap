*"* components of interface /OOP/IF_LIST
interface /OOP/IF_LIST
  public .


  interfaces /OOP/IF_COLLECTION .

  aliases ADD
    for /OOP/IF_COLLECTION~ADD .
  aliases ADDALL
    for /OOP/IF_COLLECTION~ADDALL .
  aliases CLEAR
    for /OOP/IF_COLLECTION~CLEAR .
  aliases CONTAINS
    for /OOP/IF_COLLECTION~CONTAINS .
  aliases CONTAINSALL
    for /OOP/IF_COLLECTION~CONTAINSALL .
  aliases ISEMPTY
    for /OOP/IF_COLLECTION~ISEMPTY .
  aliases ITERATOR
    for /OOP/IF_COLLECTION~ITERATOR .
  aliases REMOVE
    for /OOP/IF_COLLECTION~REMOVE .
  aliases REMOVEALL
    for /OOP/IF_COLLECTION~REMOVEALL .
  aliases RETAINALL
    for /OOP/IF_COLLECTION~RETAINALL .
  aliases SIZE
    for /OOP/IF_COLLECTION~SIZE .
  aliases TOARRAY
    for /OOP/IF_COLLECTION~TOARRAY .

  methods ADDAT
    importing
      !INDEX type I
      !ELEMENT type ref to /OOP/CL_OBJECT .
  type-pools ABAP .
  methods ADDALLAT
    importing
      !INDEX type I
      !COLLECTION type ref to /OOP/IF_COLLECTION
    returning
      value(RETURNING) type ABAP_BOOL .
  methods GET
    importing
      !INDEX type I
    returning
      value(RETURNING) type ref to /OOP/CL_OBJECT .
  methods INDEXOF
    importing
      !OBJECT type ref to /OOP/CL_OBJECT
    returning
      value(RETURNING) type I .
  methods LASTINDEXOF
    importing
      !OBJECT type ref to /OOP/CL_OBJECT
    returning
      value(RETURNING) type I .
  methods LISTITERATOR
    returning
      value(RETURNING) type ref to /OOP/IF_LISTITERATOR .
  methods LISTITERATORAT
    importing
      !INDEX type I
    returning
      value(RETURNING) type ref to /OOP/IF_LISTITERATOR .
  methods REMOVEAT
    importing
      !INDEX type I
    returning
      value(RETURNING) type ref to /OOP/CL_OBJECT .
  methods SET
    importing
      !INDEX type I
      !ELEMENT type ref to /OOP/CL_OBJECT
    returning
      value(RETURNING) type ref to /OOP/CL_OBJECT .
endinterface.
