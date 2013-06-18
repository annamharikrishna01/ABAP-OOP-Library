*"* components of interface /OOP/IF_OAUTH_TMP_REQ_AUT_REPO
interface /OOP/IF_OAUTH_TMP_REQ_AUT_REPO
  public .


  methods FIND_BY_ID
    importing
      !CONSUMER_KEY type /OOP/OA_CONSUMER_KEY
      !TIMESTAMP type /OOP/OA_TIMESTAMP
      !NONCE type /OOP/OA_NONCE
    returning
      value(RETURNING) type ref to /OOP/CL_OAUTH_TMP_REQ_AUT .
  methods CREATE
    importing
      !REQUEST type ref to /OOP/CL_OAUTH_TMP_REQ_AUT
    raising
      /OOP/CX_OAUTH_RECORD_EXISTS .
endinterface.
