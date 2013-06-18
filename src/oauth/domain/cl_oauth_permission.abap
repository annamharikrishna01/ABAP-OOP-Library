class /OOP/CL_OAUTH_PERMISSION definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public

  global friends /OOP/IF_OAUTH_PERMISSION_REPO .

public section.
*"* public components of class /OOP/CL_OAUTH_PERMISSION
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !RESOURCE_ID type /OOP/RESOURCEID
      !CREATE_ALLOWED type /OOP/OA_PERM_CREATE
      !READ_ALLOWED type /OOP/OA_PERM_READ
      !UPDATE_ALLOWED type /OOP/OA_PERM_UPDATE
      !DELETE_ALLOWED type /OOP/OA_PERM_DELETE
      !HEAD_ALLOWED type /OOP/OA_PERM_HEAD .
  methods CLIENT_ID
    returning
      value(RETURNING) type /OOP/OA_CLIENT_ID .
  methods RESOURCE_ID
    returning
      value(RETURNING) type /OOP/RESOURCEID .
  methods CREATE_ALLOWED
    returning
      value(RETURNING) type /OOP/OA_PERM_CREATE .
  methods READ_ALLOWED
    returning
      value(RETURNING) type /OOP/OA_PERM_READ .
  methods UPDATE_ALLOWED
    returning
      value(RETURNING) type /OOP/OA_PERM_UPDATE .
  methods DELETE_ALLOWED
    returning
      value(RETURNING) type /OOP/OA_PERM_DELETE .
  methods HEAD_ALLOWED
    returning
      value(RETURNING) type /OOP/OA_PERM_HEAD .
  protected section.
*"* protected components of class /OOP/CL_OAUTH_PERMISSION
*"* do not include other source files here!!!
  private section.
*"* private components of class /OOP/CL_OAUTH_PERMISSION
*"* do not include other source files here!!!

    data _client_id type /oop/oa_client_id .
    data _resource_id type /oop/resourceid .
    data _create_allowed type /oop/oa_perm_create .
    data _read_allowed type /oop/oa_perm_read .
    data _update_allowed type /oop/oa_perm_update .
    data _delete_allowed type /oop/oa_perm_delete .
    data _head_allowed type /oop/oa_perm_head .
ENDCLASS.



CLASS /OOP/CL_OAUTH_PERMISSION IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method client_id.
  returning = _client_id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_ID                      TYPE        /OOP/OA_CLIENT_ID
* | [--->] RESOURCE_ID                    TYPE        /OOP/RESOURCEID
* | [--->] CREATE_ALLOWED                 TYPE        /OOP/OA_PERM_CREATE
* | [--->] READ_ALLOWED                   TYPE        /OOP/OA_PERM_READ
* | [--->] UPDATE_ALLOWED                 TYPE        /OOP/OA_PERM_UPDATE
* | [--->] DELETE_ALLOWED                 TYPE        /OOP/OA_PERM_DELETE
* | [--->] HEAD_ALLOWED                   TYPE        /OOP/OA_PERM_HEAD
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _client_id = client_id.
  _resource_id = resource_id.
  _create_allowed = create_allowed.
  _read_allowed = read_allowed.
  _update_allowed = update_allowed.
  _delete_allowed = delete_allowed.
  _head_allowed = head_allowed.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->CREATE_ALLOWED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_PERM_CREATE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_allowed.
  returning = _create_allowed.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->DELETE_ALLOWED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_PERM_DELETE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method delete_allowed.
  returning = _delete_allowed.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->HEAD_ALLOWED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_PERM_HEAD
* +--------------------------------------------------------------------------------------</SIGNATURE>
method head_allowed.
  returning = _head_allowed.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->READ_ALLOWED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_PERM_READ
* +--------------------------------------------------------------------------------------</SIGNATURE>
method read_allowed.
  returning = _read_allowed.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->RESOURCE_ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/RESOURCEID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method resource_id.
  returning = _resource_id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_PERMISSION->UPDATE_ALLOWED
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_PERM_UPDATE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method update_allowed.
  returning = _update_allowed.
endmethod.
ENDCLASS.
