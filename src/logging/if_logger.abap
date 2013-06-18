*"* components of interface /OOP/IF_LOGGER
interface /OOP/IF_LOGGER
  public .


  methods INFO
    importing
      !MESSAGE type STRING .
  methods WARNING
    importing
      !MESSAGE type STRING .
  methods ERROR
    importing
      !MESSAGE type STRING .
  methods SUCCESS
    importing
      !MESSAGE type STRING .
  methods FROM_BAPI_MESSAGE
    importing
      !BAPIRET type BAPIRET2 .
  methods FROM_BAPI_MESSAGE_TABLE
    importing
      !BAPIRETTAB type BAPIRET2_T .
  methods GET_OBJECT
    returning
      value(RETURNING) type BALOBJ_D .
  methods GET_SUBOBJECT
    returning
      value(RETURNING) type BALSUBOBJ .
  methods GET_LOG_NUMBER
    returning
      value(RETURNING) type BALOGNR .
endinterface.
