*"* local class implementation for public class
*"* use this source file for the implementation part of
*"* local helper classes

*----------------------------------------------------------------------*
*       CLASS lcl_iterator IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_iterator implementation.
  method constructor.
    super->constructor( ).
    me->enclosinglist = enclosinglist.
    me->expectedmodcount = enclosinglist->modcount.
  endmethod.                    "constructor
  method /oop/if_iterator~hasnext.
    if me->cursor <> enclosinglist->size( ).
      returning = abap_true.
      return.
    else.
      returning = abap_false.
      return.
    endif.
  endmethod.                    "/oop/if_iterator~HASNEXT
  method /oop/if_iterator~next.
    me->checkforcomodification( ).
    try.
        data next type ref to /oop/cl_object.
        next = enclosinglist->get( me->cursor ).
        me->lastret = me->cursor.
        me->cursor = me->cursor + 1.
        returning = next.
        return.
      catch /oop/cx_indexoutofbounds.
        me->checkforcomodification( ). " Check if this exception is caused by a concurrent modification
        raise exception type /oop/cx_nosuchelement. " Not a concurrent modification, element simply not found
    endtry.
  endmethod.                    "/oop/if_iterator~NEXT
  method /oop/if_iterator~remove.
    if lastret = -1.
      raise exception type /oop/cx_illegalstate.
    endif.
    me->checkforcomodification( ).
    try.
        enclosinglist->removeat( index = me->lastret ).
        if me->lastret < me->cursor.
          me->cursor = me->cursor - 1.
        endif.
        me->lastret = -1.
        me->expectedmodcount = enclosinglist->modcount.
      catch /oop/cx_indexoutofbounds.
        raise exception type /oop/cx_concurrmodification.
    endtry.
  endmethod.                    "/oop/if_iterator~REMOVE
  method checkforcomodification.
    if enclosinglist->modcount <> me->expectedmodcount.
      raise exception type /oop/cx_concurrmodification.
    endif.
  endmethod.                    "checkforcomodification
endclass.                    "lcl_iterator IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_listiterator IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_listiterator implementation.
  method constructor.
    super->constructor( enclosinglist ).
    me->cursor = index.
  endmethod.                    "constructor
  method /oop/if_listiterator~add.
    me->checkforcomodification( ).
    try.
        enclosinglist->addat( index = me->cursor element = element ).
        me->cursor = me->cursor + 1.
        me->lastret = -1.
        me->expectedmodcount = enclosinglist->modcount.
      catch /oop/cx_indexoutofbounds.
        raise exception type /oop/cx_concurrmodification.
    endtry.
  endmethod.                    "/oop/if_listiterator~ADD
  method /oop/if_listiterator~hasprevious.
    if me->cursor <> 0.
      returning = abap_true.
      return.
    else.
      returning = abap_false.
      return.
    endif.
  endmethod.                    "/oop/if_listiterator~HASPREVIOUS
  method /oop/if_listiterator~nextindex.
    returning = me->cursor.
    return.
  endmethod.                    "/oop/if_listiterator~NEXTINDEX
  method /oop/if_listiterator~previous.
    me->checkforcomodification( ).
    try.
        data previousindex type i.
        previousindex = me->cursor - 1.
        data previous type ref to /oop/cl_object.
        previous = enclosinglist->get( previousindex ).
        me->lastret = previousindex.
        me->cursor = previousindex.
        returning = previous.
        return.
      catch /oop/cx_indexoutofbounds.
        me->checkforcomodification( ). " Check if this exception is caused by a concurrent modification
        raise exception type /oop/cx_nosuchelement. " Not a concurrent modification, element simply not found
    endtry.
  endmethod.                    "/oop/if_listiterator~PREVIOUS
  method /oop/if_listiterator~previousindex.
    returning = me->cursor - 1.
    return.
  endmethod.                    "/oop/if_listiterator~PREVIOUSINDEX
  method /oop/if_listiterator~set.
    if lastret = -1.
      raise exception type /oop/cx_illegalstate.
    endif.
    me->checkforcomodification( ).
    try.
        enclosinglist->set( index = me->lastret element = element ).
        me->expectedmodcount = enclosinglist->modcount.
      catch /oop/cx_indexoutofbounds.
        raise exception type /oop/cx_concurrmodification.
    endtry.
  endmethod.                    "/oop/if_listiterator~SET
endclass.                    "lcl_listiterator IMPLEMENTATION
