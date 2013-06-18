class /OOP/CL_OAUTH_PERMISSION_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_PERMISSION_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_PERMISSION_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_PERMISSION_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_PERMISSION_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_PERMISSION_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION_REPO->/OOP/IF_OAUTH_PERMISSION_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] PERMISSION                     TYPE REF TO /OOP/CL_OAUTH_PERMISSION
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_permission_repo~create.
  data oa_perm_record type /oop/oa_perm.
  oa_perm_record-client_id = permission->client_id( ).
  oa_perm_record-resource_id = permission->resource_id( ).
  oa_perm_record-create_allowed = permission->create_allowed( ).
  oa_perm_record-read_allowed = permission->read_allowed( ).
  oa_perm_record-update_allowed = permission->update_allowed( ).
  oa_perm_record-delete_allowed = permission->delete_allowed( ).
  oa_perm_record-head_allowed = permission->head_allowed( ).
  insert /oop/oa_perm from oa_perm_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION_REPO->/OOP/IF_OAUTH_PERMISSION_REPO~FIND_BY_CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_LIST
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_permission_repo~find_by_client_id.
  data permission_list type ref to /oop/cl_arraylist.
  create object permission_list.

  data oa_perm_records type standard table of /oop/oa_perm.
  select * from /oop/oa_perm into table oa_perm_records
    where client_id = client_id.
  if sy-subrc = 0.
    sort oa_perm_records by resource_id.
    field-symbols <oa_perm_record> type /oop/oa_perm.
    loop at oa_perm_records assigning <oa_perm_record>.
      data permission type ref to /oop/cl_oauth_permission.
      create object permission
        exporting
          client_id      = <oa_perm_record>-client_id
          resource_id    = <oa_perm_record>-resource_id
          create_allowed = <oa_perm_record>-create_allowed
          read_allowed   = <oa_perm_record>-read_allowed
          update_allowed = <oa_perm_record>-update_allowed
          delete_allowed = <oa_perm_record>-delete_allowed
          head_allowed   = <oa_perm_record>-head_allowed.
      permission_list->add( permission ).
    endloop.
  endif.

  returning = permission_list.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION_REPO->/OOP/IF_OAUTH_PERMISSION_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] RESOURCE_ID                    TYPE        /OOP/RESOURCEID
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_PERMISSION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_permission_repo~find_by_id.
  data oa_perm_record type /oop/oa_perm.
  select single * from /oop/oa_perm into oa_perm_record
    where client_id = client_id and resource_id = resource_id.
  if sy-subrc = 0.
    data permission type ref to /oop/cl_oauth_permission.
    create object permission
      exporting
        client_id      = oa_perm_record-client_id
        resource_id    = oa_perm_record-resource_id
        create_allowed = oa_perm_record-create_allowed
        read_allowed   = oa_perm_record-read_allowed
        update_allowed = oa_perm_record-update_allowed
        delete_allowed = oa_perm_record-delete_allowed
        head_allowed   = oa_perm_record-head_allowed.
    returning = permission.
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION_REPO->/OOP/IF_OAUTH_PERMISSION_REPO~UPDATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] PERMISSION                     TYPE REF TO /OOP/CL_OAUTH_PERMISSION
* | [!CX!] /OOP/CX_OAUTH_RECORD_NOT_FOUND
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_permission_repo~update.
  data client_id type /oop/oa_client_id.
  client_id = permission->client_id( ).
  data resource_id type /oop/resourceid.
  resource_id = permission->resource_id( ).
  data create_allowed type /oop/oa_perm_create.
  create_allowed = permission->create_allowed( ).
  data read_allowed type /oop/oa_perm_read.
  read_allowed = permission->read_allowed( ).
  data update_allowed type /oop/oa_perm_update.
  update_allowed = permission->update_allowed( ).
  data delete_allowed type /oop/oa_perm_delete.
  delete_allowed = permission->delete_allowed( ).
  data head_allowed type /oop/oa_perm_head.
  head_allowed = permission->head_allowed( ).
  update /oop/oa_perm
    set create_allowed = create_allowed read_allowed = read_allowed update_allowed = update_allowed delete_allowed = delete_allowed head_allowed = head_allowed
    where client_id = client_id and resource_id = resource_id.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_not_found.
  endif.
endmethod.
ENDCLASS.
