*"* local class implementation for public class
*"* use this source file for the implementation part of
*"* local helper classes

*----------------------------------------------------------------------*
*       CLASS lcl_unmodifiablecollection IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmodifiablecollection implementation.
  method constructor.
    if collection is not bound.
      raise exception type cx_sy_ref_is_initial.
    endif.
    me->collection = collection.
  endmethod.                    "constructor
  method /oop/if_collection~add.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~add
  method /oop/if_collection~addall.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~addall
  method /oop/if_collection~clear.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~clear
  method /oop/if_collection~contains.
    returning = me->collection->contains( object ).
  endmethod.                    "/oop/if_collection~contains
  method /oop/if_collection~containsall.
    returning = me->collection->containsall( collection ).
  endmethod.                    "/oop/if_collection~containsall
  method /oop/if_collection~isempty.
    returning = me->collection->isempty( ).
  endmethod.                    "/oop/if_collection~isempty
  method /oop/if_collection~iterator.
    data iterator type ref to /oop/if_iterator.
    iterator ?= me->collection->iterator( ).
    data unmod_coll_iterator type ref to lcl_unmod_coll_iterator.
    create object unmod_coll_iterator
      exporting
        iterator = iterator.
    returning = unmod_coll_iterator.
  endmethod.                    "/oop/if_collection~iterator
  method /oop/if_collection~remove.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~remove
  method /oop/if_collection~removeall.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~removeall
  method /oop/if_collection~retainall.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_collection~retainall
  method /oop/if_collection~size.
    returning = me->collection->size( ).
  endmethod.                    "/oop/if_collection~size
  method /oop/if_collection~toarray.
    returning = me->collection->toarray( ).
  endmethod.                    "/oop/if_collection~toarray
endclass.                    "lcl_unmodifiablecollection IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_unmodifiablelist IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmodifiablelist implementation.
  method constructor.
    super->constructor( list ).
    me->list = list.
  endmethod.                    "constructor
  method /oop/if_list~addallat.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_list~addallat
  method /oop/if_list~addat.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_list~addat
  method /oop/if_list~get.
    returning = me->list->get( index ).
  endmethod.                    "/oop/if_list~get
  method /oop/if_list~indexof.
    returning = me->list->indexof( object ).
  endmethod.                    "/oop/if_list~indexof
  method /oop/if_list~lastindexof.
    returning = me->list->lastindexof( object ).
  endmethod.                    "/oop/if_list~lastindexof
  method /oop/if_list~listiterator.
    returning = me->listiteratorat( 0 ).
  endmethod.                    "/oop/if_list~listiterator
  method /oop/if_list~listiteratorat.
    data listiterator type ref to /oop/if_listiterator.
    listiterator ?= me->list->listiteratorat( index ).
    data unmod_coll_listiterator type ref to lcl_unmod_coll_listiterator.
    create object unmod_coll_listiterator
      exporting
        listiterator = listiterator.
    returning = unmod_coll_listiterator.
  endmethod.                    "/oop/if_list~listiteratorat
  method /oop/if_list~removeat.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_list~removeat
  method /oop/if_list~set.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_list~set
endclass.                    "lcl_unmodifiablelist IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_unmod_collection_iterator IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmod_coll_iterator implementation.
  method constructor.
    me->iterator = iterator.
  endmethod.                    "constructor
  method /oop/if_iterator~hasnext.
    returning = me->iterator->hasnext( ).
  endmethod.                    "/oop/if_iterator~HASNEXT
  method /oop/if_iterator~next.
    returning = me->iterator->next( ).
  endmethod.                    "/oop/if_iterator~NEXT
  method /oop/if_iterator~remove.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_iterator~REMOVE
endclass.                    "lcl_unmod_collection_iterator IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_unmod_coll_listiterator IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmod_coll_listiterator implementation.
  method constructor.
    me->listiterator = listiterator.
  endmethod.                    "constructor
  method /oop/if_iterator~hasnext.
    returning = me->listiterator->hasnext( ).
  endmethod.                    "/oop/if_iterator~HASNEXT
  method /oop/if_iterator~next.
    returning = me->listiterator->next( ).
  endmethod.                    "/oop/if_iterator~NEXT
  method /oop/if_iterator~remove.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_iterator~REMOVE
  method /oop/if_listiterator~add.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_listiterator~ADD
  method /oop/if_listiterator~hasprevious.
    returning = me->listiterator->hasprevious( ).
  endmethod.                    "/oop/if_listiterator~HASPREVIOUS
  method /oop/if_listiterator~nextindex.
    returning = me->listiterator->nextindex( ).
  endmethod.                    "/oop/if_listiterator~NEXTINDEX
  method /oop/if_listiterator~previous.
    returning = me->listiterator->previous( ).
  endmethod.                    "/oop/if_listiterator~PREVIOUS
  method /oop/if_listiterator~previousindex.
    returning = me->listiterator->previousindex( ).
  endmethod.                    "/oop/if_listiterator~PREVIOUSINDEX
  method /oop/if_listiterator~set.
    raise exception type /oop/cx_unsupportedoperation.
  endmethod.                    "/oop/if_listiterator~SET
endclass.                    "lcl_unmod_coll_listiterator IMPLEMENTATION
