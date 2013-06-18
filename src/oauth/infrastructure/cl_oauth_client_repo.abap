class /OOP/CL_OAUTH_CLIENT_REPO definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create private

  global friends /OOP/CL_OAUTH_REPO_FACTORY .

public section.
*"* public components of class /OOP/CL_OAUTH_CLIENT_REPO
*"* do not include other source files here!!!

  interfaces /OOP/IF_OAUTH_CLIENT_REPO .
protected section.
*"* protected components of class /OOP/CL_OAUTH_CLIENT_REPO
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_CLIENT_REPO
*"* do not include other source files here!!!
ENDCLASS.



CLASS /OOP/CL_OAUTH_CLIENT_REPO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT_REPO->/OOP/IF_OAUTH_CLIENT_REPO~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO /OOP/CL_OAUTH_CLIENT
* | [!CX!] /OOP/CX_OAUTH_RECORD_EXISTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_client_repo~create.
  data oa_clients_record type /oop/oa_clients.
  oa_clients_record-id = client->id( ).
  oa_clients_record-secret = client->secret( ).
  oa_clients_record-name = client->name( ).
  oa_clients_record-description = client->description( ).
  oa_clients_record-company = client->company( ).
  oa_clients_record-url = client->url( ).
  insert /oop/oa_clients from oa_clients_record.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_exists.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT_REPO->/OOP/IF_OAUTH_CLIENT_REPO~FIND_BY_ID
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID                             TYPE        /OOP/OA_CLIENT_ID
* | [<-()] RETURNING                      TYPE REF TO /OOP/CL_OAUTH_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_client_repo~find_by_id.
  data oa_clients_record type /oop/oa_clients.
  select single * from /oop/oa_clients into oa_clients_record
    where id = id.
  if sy-subrc = 0.
    data client type ref to /oop/cl_oauth_client.
    create object client
      exporting
        id          = oa_clients_record-id
        secret      = oa_clients_record-secret
        name        = oa_clients_record-name
        description = oa_clients_record-description
        company     = oa_clients_record-company
        url         = oa_clients_record-url.
    returning = client.
    return.
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_CLIENT_REPO->/OOP/IF_OAUTH_CLIENT_REPO~UPDATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO /OOP/CL_OAUTH_CLIENT
* | [!CX!] /OOP/CX_OAUTH_RECORD_NOT_FOUND
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_oauth_client_repo~update.
  data id type /oop/oa_client_id.
  id = client->id( ).
  data name type /oop/oa_client_name.
  name = client->name( ).
  data description type /oop/oa_client_description.
  description = client->description( ).
  data company type /oop/oa_client_company.
  company = client->company( ).
  data url type /oop/oa_client_url.
  url = client->url( ).
  update /oop/oa_clients
    set name = name description = description company = company url = url
    where id = id.
  if sy-subrc <> 0.
    raise exception type /oop/cx_oauth_record_not_found.
  endif.
endmethod.
ENDCLASS.
