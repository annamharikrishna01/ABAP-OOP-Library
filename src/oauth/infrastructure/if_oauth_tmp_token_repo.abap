*"* components of interface /OOP/IF_OAUTH_TMP_TOKEN_REPO
interface /OOP/IF_OAUTH_TMP_TOKEN_REPO
  public .


  methods FIND_BY_ID
    importing
      !TOKEN type /OOP/OA_TOKEN
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TMP_TOKEN .
  methods CREATE
    importing
      !TMP_TOKEN type ref to /OOP/CL_OAUTH_TMP_TOKEN
    raising
      /OOP/CX_OAUTH_RECORD_EXISTS .
  methods UPDATE
    importing
      !TMP_TOKEN type ref to /OOP/CL_OAUTH_TMP_TOKEN
    raising
      /OOP/CX_OAUTH_RECORD_NOT_FOUND .
  methods DELETE
    importing
      !TMP_TOKEN type ref to /OOP/CL_OAUTH_TMP_TOKEN .
endinterface.
