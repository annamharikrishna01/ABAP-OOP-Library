*"* use this source file for any type declarations (class
*"* definitions, interfaces or data types) you need for method
*"* implementation or private method's signature

*----------------------------------------------------------------------*
*       CLASS lcl_iterator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_iterator definition inheriting from /oop/cl_object.
  public section.
    interfaces /oop/if_iterator.
    methods constructor importing enclosinglist type ref to /oop/cl_abstractlist.
  protected section.
    data enclosinglist type ref to /oop/cl_abstractlist.
    data cursor type i value 0.
    data lastret type i value -1.
    data expectedmodcount type i.
    methods checkforcomodification final.
endclass.                    "lcl_Iterator DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_listiterator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_listiterator definition inheriting from lcl_iterator final.
  public section.
    interfaces /oop/if_listiterator.
    methods constructor importing enclosinglist type ref to /oop/cl_abstractlist
                                  index type i.
endclass.                    "lcl_listiterator DEFINITION

class /oop/cl_abstractlist definition local friends lcl_iterator lcl_listiterator.
