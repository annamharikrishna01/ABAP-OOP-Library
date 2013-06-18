class /OOP/CL_LOGGER definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_LOGGER_FACTORY
                 /OOP/IF_LOGGING_REPOSITORY .

public section.
*"* public components of class /OOP/CL_LOGGER
*"* do not include other source files here!!!

  interfaces /OOP/IF_LOGGER .

  aliases ERROR
    for /OOP/IF_LOGGER~ERROR .
  aliases FROM_BAPI_MESSAGE
    for /OOP/IF_LOGGER~FROM_BAPI_MESSAGE .
  aliases FROM_BAPI_MESSAGE_TABLE
    for /OOP/IF_LOGGER~FROM_BAPI_MESSAGE_TABLE .
  aliases GET_LOG_NUMBER
    for /OOP/IF_LOGGER~GET_LOG_NUMBER .
  aliases GET_OBJECT
    for /OOP/IF_LOGGER~GET_OBJECT .
  aliases GET_SUBOBJECT
    for /OOP/IF_LOGGER~GET_SUBOBJECT .
  aliases INFO
    for /OOP/IF_LOGGER~INFO .
  aliases SUCCESS
    for /OOP/IF_LOGGER~SUCCESS .
  aliases WARNING
    for /OOP/IF_LOGGER~WARNING .

  methods CONSTRUCTOR
    importing
      !LOG_OBJECT type BALOBJ_D
      !LOG_SUBOBJECT type BALSUBOBJ
      !LOG_NUMBER type BALOGNR optional .
protected section.
*"* protected components of class /OOP/CL_LOGGER
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_LOGGER
*"* do not include other source files here!!!

  data LOG_OBJECT type BALOBJ_D .
  data LOG_SUBOBJECT type BALSUBOBJ .
  data LOG_NUMBER type BALOGNR .
  data LOGGING_REPOSITORY type ref to /OOP/CL_LOGGING_REPO_HTTP .

  methods ADD_MESSAGE
    importing
      !LOG_MESSAGE type STRING
      !LOG_MESSAGE_TYPE type SYMSGTY .
ENDCLASS.



CLASS /OOP/CL_LOGGER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~ERROR
* +-------------------------------------------------------------------------------------------------+
* | [--->] MESSAGE                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~error.
  me->add_message( log_message = message log_message_type = 'E' ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~FROM_BAPI_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] BAPIRET                        TYPE        BAPIRET2
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~from_bapi_message.
  data message type string.
  message = bapiret-message.
  me->add_message( log_message = message log_message_type = bapiret-type ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~FROM_BAPI_MESSAGE_TABLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] BAPIRETTAB                     TYPE        BAPIRET2_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~from_bapi_message_table.
  data bapiret type bapiret2.
  loop at bapirettab into bapiret.
    me->from_bapi_message( bapiret ).
  endloop.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~GET_LOG_NUMBER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        BALOGNR
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~get_log_number.
  returning = me->log_number.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~GET_OBJECT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        BALOBJ_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~get_object.
  returning = me->log_object.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~GET_SUBOBJECT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        BALSUBOBJ
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~get_subobject.
  returning = me->log_subobject.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~INFO
* +-------------------------------------------------------------------------------------------------+
* | [--->] MESSAGE                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~info.
  me->add_message( log_message = message log_message_type = 'I' ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~SUCCESS
* +-------------------------------------------------------------------------------------------------+
* | [--->] MESSAGE                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~success.
  me->add_message( log_message = message log_message_type = 'S' ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->/OOP/IF_LOGGER~WARNING
* +-------------------------------------------------------------------------------------------------+
* | [--->] MESSAGE                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_logger~warning.
  me->add_message( log_message = message log_message_type = 'W' ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_LOGGER->ADD_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] LOG_MESSAGE                    TYPE        STRING
* | [--->] LOG_MESSAGE_TYPE               TYPE        SYMSGTY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method add_message.
  if me->log_number is initial.
    me->log_number = me->logging_repository->create( log_object = me->log_object log_subobject = me->log_subobject ).
  endif.
  me->logging_repository->update( log_number = me->log_number log_message = log_message log_message_type = log_message_type ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_LOGGER->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] LOG_OBJECT                     TYPE        BALOBJ_D
* | [--->] LOG_SUBOBJECT                  TYPE        BALSUBOBJ
* | [--->] LOG_NUMBER                     TYPE        BALOGNR(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  if log_object is initial or log_subobject is initial.
    raise exception type /oop/cx_logging_error.
  endif.
  " Set log objects
  me->log_object = log_object.
  me->log_subobject = log_subobject.
  me->log_number = log_number.
  " Init client
  create object me->logging_repository.
endmethod.
ENDCLASS.
