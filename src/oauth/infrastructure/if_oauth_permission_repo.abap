*"* components of interface /OOP/IF_OAUTH_PERMISSION_REPO
interface /OOP/IF_OAUTH_PERMISSION_REPO
  public .


  methods FIND_BY_ID
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
      !RESOURCE_ID type /OOP/RESOURCEID
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_PERMISSION .
  methods FIND_BY_CLIENT_ID
    importing
      !CLIENT_ID type /OOP/OA_CLIENT_ID
    returning
      value(RETURNING) type ref to /OOP/IF_LIST .
  methods CREATE
    importing
      !PERMISSION type ref to /OOP/CL_OAUTH_PERMISSION
    raising
      /OOP/CX_OAUTH_RECORD_EXISTS .
  methods UPDATE
    importing
      !PERMISSION type ref to /OOP/CL_OAUTH_PERMISSION
    raising
      /OOP/CX_OAUTH_RECORD_NOT_FOUND .
endinterface.
