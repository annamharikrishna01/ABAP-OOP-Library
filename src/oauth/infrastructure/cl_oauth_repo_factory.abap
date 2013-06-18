class /OOP/CL_OAUTH_REPO_FACTORY definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_REPO_FACTORY
*"* do not include other source files here!!!

  class-methods CLIENT_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_CLIENT_REPO .
  class-methods PERMISSION_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_PERMISSION_REPO .
  class-methods REQUEST_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_REQUEST_REPO .
  class-methods TMP_REQ_AUT_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_TMP_REQ_AUT_REPO .
  class-methods TMP_REQ_INI_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_TMP_REQ_INI_REPO .
  class-methods TMP_TOKEN_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_TMP_TOKEN_REPO .
  class-methods TOKEN_REPO
    returning
      value(RETURNING) type ref to /OOP/IF_OAUTH_TOKEN_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_REPO_FACTORY
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_REPO_FACTORY
*"* do not include other source files here!!!

  class-data _CLIENT_REPO type ref to /OOP/IF_OAUTH_CLIENT_REPO .
  class-data _PERMISSION_REPO type ref to /OOP/IF_OAUTH_PERMISSION_REPO .
  class-data _REQUEST_REPO type ref to /OOP/IF_OAUTH_REQUEST_REPO .
  class-data _TMP_REQ_AUT_REPO type ref to /OOP/IF_OAUTH_TMP_REQ_AUT_REPO .
  class-data _TMP_REQ_INI_REPO type ref to /OOP/IF_OAUTH_TMP_REQ_INI_REPO .
  class-data _TMP_TOKEN_REPO type ref to /OOP/IF_OAUTH_TMP_TOKEN_REPO .
  class-data _TOKEN_REPO type ref to /OOP/IF_OAUTH_TOKEN_REPO .
ENDCLASS.



CLASS /OOP/CL_OAUTH_REPO_FACTORY IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>CLIENT_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_CLIENT_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method client_repo.
  if _client_repo is not bound.
    create object _client_repo type /oop/cl_oauth_client_repo.
  endif.
  returning = _client_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>PERMISSION_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_PERMISSION_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method permission_repo.
  if _permission_repo is not bound.
    create object _permission_repo type /oop/cl_oauth_permission_repo.
  endif.
  returning = _permission_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>REQUEST_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_REQUEST_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method request_repo.
  if _request_repo is not bound.
    create object _request_repo type /oop/cl_oauth_request_repo.
  endif.
  returning = _request_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>TMP_REQ_AUT_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_TMP_REQ_AUT_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method tmp_req_aut_repo.
  if _tmp_req_aut_repo is not bound.
    create object _tmp_req_aut_repo type /oop/cl_oauth_tmp_req_aut_repo.
  endif.
  returning = _tmp_req_aut_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>TMP_REQ_INI_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_TMP_REQ_INI_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method tmp_req_ini_repo.
  if _tmp_req_ini_repo is not bound.
    create object _tmp_req_ini_repo type /oop/cl_oauth_tmp_req_ini_repo.
  endif.
  returning = _tmp_req_ini_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>TMP_TOKEN_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_TMP_TOKEN_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method tmp_token_repo.
  if _tmp_token_repo is not bound.
    create object _tmp_token_repo type /oop/cl_oauth_tmp_token_repo.
  endif.
  returning = _tmp_token_repo.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method /OOP/CL_OAUTH_REPO_FACTORY=>TOKEN_REPO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE REF TO /OOP/IF_OAUTH_TOKEN_REPO
* +--------------------------------------------------------------------------------------</SIGNATURE>
method token_repo.
  if _token_repo is not bound.
    create object _token_repo type /oop/cl_oauth_token_repo.
  endif.
  returning = _token_repo.
endmethod.
ENDCLASS.
