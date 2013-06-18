*"* components of interface /OOP/IF_OAUTH_CLIENT_REPO
interface /OOP/IF_OAUTH_CLIENT_REPO
  public .


  methods FIND_BY_ID
    importing
      !ID type /OOP/OA_CLIENT_ID
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_CLIENT .
  methods CREATE
    importing
      !CLIENT type ref to /OOP/CL_OAUTH_CLIENT
    raising
      /OOP/CX_OAUTH_RECORD_EXISTS .
  methods UPDATE
    importing
      !CLIENT type ref to /OOP/CL_OAUTH_CLIENT
    raising
      /OOP/CX_OAUTH_RECORD_NOT_FOUND .
endinterface.
