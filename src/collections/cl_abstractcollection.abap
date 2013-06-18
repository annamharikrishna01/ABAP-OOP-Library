class /OOP/CL_ABSTRACTCOLLECTION definition
  public
  inheriting from /OOP/CL_OBJECT
  abstract
  create public .

public section.
*"* public components of class /OOP/CL_ABSTRACTCOLLECTION
*"* do not include other source files here!!!

  interfaces /OOP/IF_COLLECTION
      abstract methods ITERATOR
                       SIZE .

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
protected section.
*"* protected components of class /OOP/CL_ABSTRACTCOLLECTION
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_ABSTRACTCOLLECTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_ABSTRACTCOLLECTION IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~ADD
* +-------------------------------------------------------------------------------------------------+
* | [--->] ELEMENT                        TYPE REF TO /OOP/CL_OBJECT
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~add.
  raise exception type /oop/cx_unsupportedoperation.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~ADDALL
* +-------------------------------------------------------------------------------------------------+
* | [--->] COLLECTION                     TYPE REF TO /OOP/IF_COLLECTION
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~addall.
  data modified type abap_bool.
  modified = abap_false.
  data iterator type ref to /oop/if_iterator.
  iterator = collection->iterator( ).
  while iterator->hasnext( ) = abap_true.
    data next type ref to /oop/cl_object.
    next = iterator->next( ).
    if me->add( next ) = abap_true.
      modified = abap_true.
    endif.
  endwhile.
  returning = modified.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~CLEAR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~clear.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  while iterator->hasnext( ) = abap_true.
    iterator->next( ).
    iterator->remove( ).
  endwhile.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~CONTAINS
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT                         TYPE REF TO /OOP/CL_OBJECT
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~contains.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  if object is not bound.
    while iterator->hasnext( ) = abap_true.
      if object = iterator->next( ).
        returning = abap_true.
        return.
      endif.
    endwhile.
  else.
    while iterator->hasnext( ) = abap_true.
      data obj type ref to /oop/cl_object.
      obj = iterator->next( ).
      if obj->equals( object ) = abap_true.
        returning = abap_true.
        return.
      endif.
    endwhile.
  endif.
  " Return false if the object is not found
  returning = abap_false.
  return.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~CONTAINSALL
* +-------------------------------------------------------------------------------------------------+
* | [--->] COLLECTION                     TYPE REF TO /OOP/IF_COLLECTION
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~containsall.
  data iterator type ref to /oop/if_iterator.
  iterator = collection->iterator( ).
  while iterator->hasnext( ) = abap_true.
    data next type ref to /oop/cl_object.
    next = iterator->next( ).
    if me->contains( next ) = abap_false.
      returning = abap_false.
      return.
    endif.
  endwhile.
  returning = abap_true.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~ISEMPTY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~isempty.
  if me->size( ) = 0.
    returning = abap_true.
    return.
  endif.
  returning = abap_false.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~REMOVE
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT                         TYPE REF TO /OOP/CL_OBJECT
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~remove.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  if object is not bound.
    while iterator->hasnext( ) = abap_true.
      if object = iterator->next( ).
        iterator->remove( ).
        returning = abap_true.
        return.
      endif.
    endwhile.
  else.
    while iterator->hasnext( ) = abap_true.
      data obj type ref to /oop/cl_object.
      obj = iterator->next( ).
      if obj->equals( object ) = abap_true.
        iterator->remove( ).
        returning = abap_true.
        return.
      endif.
    endwhile.
  endif.
  " Return false if the object is not found
  returning = abap_false.
  return.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~REMOVEALL
* +-------------------------------------------------------------------------------------------------+
* | [--->] COLLECTION                     TYPE REF TO /OOP/IF_COLLECTION
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~removeall.
  data modified type abap_bool.
  modified = abap_false.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  while iterator->hasnext( ) = abap_true.
    data next type ref to /oop/cl_object.
    next = iterator->next( ).
    if collection->contains( next ) = abap_true.
      iterator->remove( ).
      modified = abap_true.
    endif.
  endwhile.
  returning = modified.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~RETAINALL
* +-------------------------------------------------------------------------------------------------+
* | [--->] COLLECTION                     TYPE REF TO /OOP/IF_COLLECTION
* | [<-()] RETURNING                      TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~retainall.
  data modified type abap_bool.
  modified = abap_false.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  while iterator->hasnext( ) = abap_true.
    data next type ref to /oop/cl_object.
    next = iterator->next( ).
    if collection->contains( next ) = abap_false.
      iterator->remove( ).
      modified = abap_true.
    endif.
  endwhile.
  returning = modified.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_ABSTRACTCOLLECTION->/OOP/IF_COLLECTION~TOARRAY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/ARRAY
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_collection~toarray.
  data array type /oop/array.
  data iterator type ref to /oop/if_iterator.
  iterator = me->iterator( ).
  while iterator->hasnext( ) = abap_true.
    data next type ref to /oop/cl_object.
    next = iterator->next( ).
    append next to array.
  endwhile.
  returning = array.
endmethod.
ENDCLASS.
