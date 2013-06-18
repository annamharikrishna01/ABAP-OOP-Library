class /OOP/CL_RESOURCE definition
  public
  inheriting from /OOP/CL_OBJECT
  abstract
  create public

  global friends /OOP/IF_DISPATCHER .

public section.
*"* public components of class /OOP/CL_RESOURCE
*"* do not include other source files here!!!

  interfaces /OOP/IF_RESOURCE .

  aliases CREATE
    for /OOP/IF_RESOURCE~CREATE .
  aliases DELETE
    for /OOP/IF_RESOURCE~DELETE .
  aliases HEAD
    for /OOP/IF_RESOURCE~HEAD .
  aliases ID
    for /OOP/IF_RESOURCE~ID .
  aliases READ
    for /OOP/IF_RESOURCE~READ .
  aliases UPDATE
    for /OOP/IF_RESOURCE~UPDATE .
  aliases URIPATTERN
    for /OOP/IF_RESOURCE~URIPATTERN .
protected section.
*"* protected components of class /OOP/CL_RESOURCE
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_RESOURCE
*"* do not include other source files here!!!

  data _ID type /OOP/RESOURCEID .
  data _URIPATTERN type /OOP/URIPATTERN .
ENDCLASS.



CLASS /OOP/CL_RESOURCE IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~create.
*/**
* Handle the POST method:
* - parses the HTTP body and instantiates a new resource
* - creates the new resource using the repository
*
* Method specification:
* - SAFE: no
* - IDEMPOTENT: no
*
* Common responses:
* - 200 with the created resource as HTTP body
* - 201 without HTTP body, with Location header referring to the created resource
* - 204 without HTTP body, same as 200 but the created resource is not returned
*/
  " Method not allowed unless overridden by subclass
  data message type string.
  message e005(/oop/rest) into message.
  response->send_error( code = /oop/cl_http_status_codes=>method_not_allowed message = message ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~DELETE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~delete.
*/**
* Handle the DELETE method:
* - deletes the referred resource
*
* Method specification:
* - SAFE: no
* - IDEMPOTENT: yes
*
* Common responses:
* - 200 with the deleted resource as HTTP body
* - 202 without HTTP body, used for asynchronous processing
* - 204 without HTTP body, same as 200 but the deleted resource is not returned
*/
  " Method not allowed unless overridden by subclass
  data message type string.
  message e005(/oop/rest) into message.
  response->send_error( code = /oop/cl_http_status_codes=>method_not_allowed message = message ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~HEAD
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~head.
*/**
* Handle the HEAD method:
* - exactly the same as the GET method, but ONLY returns the headers
*
* Method specification:
* - SAFE: yes
* - IDEMPOTENT: yes
*
* Common responses:
* - 200 without HTTP body
* - 404 without HTTP body, if the requested resource was not found
*/
  " Method not allowed unless overridden by subclass
  data message type string.
  message e002(/oop/rest) into message.
  response->send_error( code = /oop/cl_http_status_codes=>method_not_allowed message = message ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/RESOURCEID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~id.
  returning = _id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~READ
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~read.
*/**
* Handle the GET method:
* - retrieves the referred resource from the repository
* - formats the resource into the requested representation and
* - returns the representation as the HTTP body using either the SEND_BINARY or SEND_TEXT methods of the response
*
* Method specification:
* - SAFE: yes
* - IDEMPOTENT: yes
*
* Common responses:
* - 200 with the requested resource as HTTP body
* - 404 without HTTP body, if the requested resource was not found
*/
  " Method not allowed unless overridden by subclass
  data message type string.
  message e005(/oop/rest) into message.
  response->send_error( code = /oop/cl_http_status_codes=>method_not_allowed message = message ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~UPDATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [--->] RESPONSE                       TYPE REF TO /OOP/IF_RESPONSE
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~update.
*/**
* Handle the PUT method:
* - this method updates an existing resource, or creates a new resource if the referred resource does not exist yet
* - retrieves the referred resource from the repository
* - parses the HTTP body and instantiates a new resource
* - creates a new, or replaces the existing resource with the new resource
*
* Method specification:
* - SAFE: no
* - IDEMPOTENT: yes
*
* Common responses:
* - 200 with the updated resource as HTTP body
* - 201 without HTTP body, with Location header referring to the updated resource
* - 204 without HTTP body, same as 200 but the updated resource is not returned
*/
  " Method not allowed unless overridden by subclass
  data message type string.
  message e005(/oop/rest) into message.
  response->send_error( code = /oop/cl_http_status_codes=>method_not_allowed message = message ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_RESOURCE->/OOP/IF_RESOURCE~URIPATTERN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/URIPATTERN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method /oop/if_resource~uripattern.
  returning = _uripattern.
endmethod.
ENDCLASS.
