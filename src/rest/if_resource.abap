*"* components of interface /OOP/IF_RESOURCE
interface /OOP/IF_RESOURCE
  public .


  methods CREATE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods READ
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods UPDATE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods DELETE
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods HEAD
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
      !RESPONSE type ref to /OOP/IF_RESPONSE .
  methods ID
    returning
      value(RETURNING) type /OOP/RESOURCEID .
  methods URIPATTERN
    returning
      value(RETURNING) type /OOP/URIPATTERN .
endinterface.
