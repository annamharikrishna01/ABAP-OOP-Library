class /OOP/CL_LOGGER_FACTORY definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private .

public section.
*"* public components of class /OOP/CL_LOGGER_FACTORY
*"* do not include other source files here!!!

  class-methods CREATE_CUSTOM_LOG
    importing
      !OBJECT type BALOBJ_D
      !SUBOBJECT type BALSUBOBJ
    returning
      value(RETURNING) type ref to /OOP/CL_LOGGER .
  class-methods GET_EXISTING_LOG
    importing
      !LOG_NUMBER type BALOGNR
    returning
      value(RETURNING) type ref to /OOP/CL_LOGGER .
  class-methods GET_SESSION_LOG
    importing
      !OBJECT type BALOBJ_D optional
      !SUBOBJECT type BALSUBOBJ optional
    returning
      value(RETURNING) type ref to /OOP/CL_LOGGER .
protected section.
*"* protected components of class /OOP/CL_LOGGER_FACTORY
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_LOGGER_FACTORY
*"* do not include other source files here!!!

  class-data LOGGER type ref to /OOP/CL_LOGGER .
ENDCLASS.



CLASS /OOP/CL_LOGGER_FACTORY IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_LOGGER_FACTORY=>CREATE_CUSTOM_LOG
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT                         TYPE        BALOBJ_D
* | [--->] SUBOBJECT                      TYPE        BALSUBOBJ
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_LOGGER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_custom_log.
  data custom_logger type ref to /oop/cl_logger.
  create object custom_logger
    exporting
      log_object    = object
      log_subobject = subobject.
  returning = custom_logger.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_LOGGER_FACTORY=>GET_EXISTING_LOG
* +-------------------------------------------------------------------------------------------------+
* | [--->] LOG_NUMBER                     TYPE        BALOGNR
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_LOGGER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method get_existing_log.
  data logging_repository type ref to /oop/cl_logging_repo_http.
  create object logging_repository.
  returning = logging_repository->find_by_id( log_number ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_LOGGER_FACTORY=>GET_SESSION_LOG
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT                         TYPE        BALOBJ_D(optional)
* | [--->] SUBOBJECT                      TYPE        BALSUBOBJ(optional)
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_LOGGER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method get_session_log.
  if /oop/cl_logger_factory=>logger is not bound.
    /oop/cl_logger_factory=>logger = /oop/cl_logger_factory=>create_custom_log( object = object subobject = subobject ).
  endif.
  returning = /oop/cl_logger_factory=>logger.
endmethod.
ENDCLASS.
