*"* components of interface /OOP/IF_OAUTH_TOKEN_REPO
interface /OOP/IF_OAUTH_TOKEN_REPO
  public .


  methods FIND_BY_ID
    importing
      !TOKEN type /OOP/OA_TOKEN
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TOKEN .
  methods CREATE
    importing
      !TOKEN type ref to /OOP/CL_OAUTH_TOKEN
    raising
      /OOP/CX_OAUTH_RECORD_EXISTS .
endinterface.
