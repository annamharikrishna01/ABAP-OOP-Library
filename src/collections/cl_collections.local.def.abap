*"* use this source file for any type declarations (class
*"* definitions, interfaces or data types) you need for method
*"* implementation or private method's signature

*----------------------------------------------------------------------*
*       CLASS lcl_unmodifiablecollection DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmodifiablecollection definition.
  public section.
    interfaces /oop/if_collection.
    interfaces if_serializable_object.
    aliases add for /oop/if_collection~add .
    aliases addall for /oop/if_collection~addall .
    aliases clear for /oop/if_collection~clear .
    aliases contains for /oop/if_collection~contains .
    aliases containsall for /oop/if_collection~containsall .
    aliases isempty for /oop/if_collection~isempty .
    aliases iterator for /oop/if_collection~iterator .
    aliases remove for /oop/if_collection~remove .
    aliases removeall for /oop/if_collection~removeall .
    aliases retainall for /oop/if_collection~retainall .
    aliases size for /oop/if_collection~size .
    aliases toarray for /oop/if_collection~toarray .
    methods constructor importing collection type ref to /oop/if_collection.
  private section.
    data collection type ref to /oop/if_collection.
endclass.                    "lcl_UnmodifiableCollection DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_unmodifiablelist DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmodifiablelist definition inheriting from lcl_unmodifiablecollection final.
  public section.
    interfaces /oop/if_list.
    aliases addallat for /oop/if_list~addallat.
    aliases addat for /oop/if_list~addat.
    aliases get for /oop/if_list~get.
    aliases indexof for /oop/if_list~indexof.
    aliases lastindexof for /oop/if_list~lastindexof.
    aliases listiterator for /oop/if_list~listiterator.
    aliases listiteratorat for /oop/if_list~listiteratorat.
    aliases removeat for /oop/if_list~removeat.
    aliases set for /oop/if_list~set.
    methods constructor importing list type ref to /oop/if_list.
  private section.
    data list type ref to /oop/if_list.
endclass.                    "lcl_unmodifiablelist DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_unmod_collection_iterator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmod_coll_iterator definition final.
  public section.
    interfaces /oop/if_iterator.
    methods constructor importing iterator type ref to /oop/if_iterator.
  private section.
    data iterator type ref to /oop/if_iterator.
endclass.                    "lcl_unmod_collection_iterator DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_unmod_coll_listiterator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_unmod_coll_listiterator definition final.
  public section.
    interfaces /oop/if_listiterator.
    methods constructor importing listiterator type ref to /oop/if_listiterator.
  private section.
    data listiterator type ref to /oop/if_listiterator.
endclass.                    "lcl_unmod_coll_listiterator DEFINITION
