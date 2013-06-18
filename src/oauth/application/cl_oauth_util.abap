class /OOP/CL_OAUTH_UTIL definition
  public
  inheriting from /OOP/CL_OBJECT
  final
  create public .

public section.
*"* public components of class /OOP/CL_OAUTH_UTIL
*"* do not include other source files here!!!

  methods CONSTRUCTOR .
  methods BASE_STRING_FROM_REQUEST
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
    returning
      value(RETURNING) type STRING .
  methods CREATE_BASE_STRING
    importing
      !REQUEST_METHOD type STRING
      !BASE_STRING_URI type STRING
      !REQUEST_PARAMETERS type TIHTTPNVP
    returning
      value(RETURNING) type STRING .
  methods CREATE_SIGNATURE
    importing
      !CLIENT_SECRET type /OOP/OA_CLIENT_SECRET
      !TOKEN_SECRET type /OOP/OA_TOKEN_SECRET
      !BASE_STRING type STRING
    returning
      value(RETURNING) type /OOP/OA_SIGNATURE
    raising
      /OOP/CX_OAUTH_SIGNATURE_ERROR .
  methods NEW_AUTHENTICITY_TOKEN
    returning
      value(RETURNING) type /OOP/OA_AUTHENTICITY_TOKEN .
  methods NEW_CLIENT_ID
    returning
      value(RETURNING) type /OOP/OA_CLIENT_ID .
  methods NEW_CLIENT_SECRET
    returning
      value(RETURNING) type /OOP/OA_CLIENT_SECRET .
  methods NEW_TOKEN
    returning
      value(RETURNING) type /OOP/OA_TOKEN .
  methods NEW_TOKEN_SECRET
    returning
      value(RETURNING) type /OOP/OA_TOKEN_SECRET .
  methods NEW_VERIFIER
    returning
      value(RETURNING) type /OOP/OA_VERIFIER .
  methods UNIX_TIMESTAMP
    returning
      value(RETURNING) type I .
protected section.
*"* protected components of class /OOP/CL_OAUTH_UTIL
*"* do not include other source files here!!!
private section.
*"* private components of class /OOP/CL_OAUTH_UTIL
*"* do not include other source files here!!!

  types:
    TH_IGNORED_CODES type hashed table of string with unique key table_line .

  data _IGNORED_CODES type TH_IGNORED_CODES .

  methods _BASE_STRING_URI
    importing
      !REQUEST type ref to /OOP/IF_REQUEST
    returning
      value(RETURNING) type STRING .
  methods _ENCODE_STRING
    importing
      !THE_STRING type STRING
    returning
      value(RETURNING) type STRING .
  methods _INIT_IGNORED_CODES .
  methods _RANDOM_STRING
    importing
      !LENGTH type I
    returning
      value(RETURNING) type STRING .
ENDCLASS.



CLASS /OOP/CL_OAUTH_UTIL IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->BASE_STRING_FROM_REQUEST
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method base_string_from_request.
  data request_method type string.
  data base_string_uri type string.
  data request_parameters type tihttpnvp.
  request_method = request->get_method( ).
  base_string_uri = _base_string_uri( request ).
  request_parameters = request->list_parameters( ).
  returning = create_base_string( request_method = request_method base_string_uri = base_string_uri request_parameters = request_parameters ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method constructor.
  super->constructor( ).
  _init_ignored_codes( ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->CREATE_BASE_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST_METHOD                 TYPE        STRING
* | [--->] BASE_STRING_URI                TYPE        STRING
* | [--->] REQUEST_PARAMETERS             TYPE        TIHTTPNVP
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_base_string.
  " Collect all parameters into a sorted list
  data ts_parameters type sorted table of ihttpnvp with non-unique key name.
  insert lines of request_parameters into table ts_parameters.
  " Exclude OAuth signature from base string generation
  delete table ts_parameters with table key name = /oop/cl_oauth_parameters=>oauth_signature.

  " Create base string parts
  " - First part is the request method, unchanged
  data base_string_part1 type string.
  base_string_part1 = request_method.
  " - Second part is the url encoded base string uri
  data base_string_part2 type string.
  base_string_part2 = _encode_string( base_string_uri ).
  " - Third part are all the parameters concatenated and url encoded
  data base_string_part3 type string.
  data parameter_string type string.
  data is_first type abap_bool value abap_true.
  field-symbols <parameter> type ihttpnvp.
  loop at ts_parameters assigning <parameter>.
    if is_first = abap_true.
      concatenate <parameter>-name `=` <parameter>-value into parameter_string.
      is_first = abap_false.
    else.
      concatenate parameter_string `&` <parameter>-name `=` <parameter>-value into parameter_string.
    endif.
  endloop.
  base_string_part3 = _encode_string( parameter_string ).

  " Concatenate all parts into the resulting base string
  data base_string type string.
  concatenate base_string_part1 `&` base_string_part2 `&` base_string_part3 into base_string.
  returning = base_string.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->CREATE_SIGNATURE
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT_SECRET                  TYPE        /OOP/OA_CLIENT_SECRET
* | [--->] TOKEN_SECRET                   TYPE        /OOP/OA_TOKEN_SECRET
* | [--->] BASE_STRING                    TYPE        STRING
* | [<-()] RETURNING                      TYPE        /OOP/OA_SIGNATURE
* | [!CX!] /OOP/CX_OAUTH_SIGNATURE_ERROR
* +--------------------------------------------------------------------------------------</SIGNATURE>
method create_signature.
  " Create key
  data key type string.
  data key_binary type xstring.
  data converter type ref to cl_abap_conv_out_ce.
  concatenate client_secret `&` token_secret into key.
  converter = cl_abap_conv_out_ce=>create( ).
  converter->convert( exporting data = key importing buffer = key_binary ).

  " Create HMAC-SHA1 digest and return this as the signature
  data signature type string.
  try.
      call method cl_abap_hmac=>calculate_hmac_for_char
        exporting
          if_algorithm     = 'SHA1'
          if_key           = key_binary
          if_data          = base_string
        importing
          ef_hmacb64string = signature.
    catch cx_abap_message_digest.
      raise exception type /oop/cx_oauth_signature_error.
  endtry.
  returning = signature.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_AUTHENTICITY_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_AUTHENTICITY_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_authenticity_token.
  returning = _random_string( length = 40 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_CLIENT_ID
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_ID
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_client_id.
  returning = _random_string( length = 6 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_CLIENT_SECRET
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_CLIENT_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_client_secret.
  returning = _random_string( length = 40 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_TOKEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_token.
  returning = _random_string( length = 40 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_TOKEN_SECRET
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_TOKEN_SECRET
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_token_secret.
  returning = _random_string( length = 40 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->NEW_VERIFIER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        /OOP/OA_VERIFIER
* +--------------------------------------------------------------------------------------</SIGNATURE>
method new_verifier.
  returning = _random_string( length = 6 ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method /OOP/CL_OAUTH_UTIL->UNIX_TIMESTAMP
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RETURNING                      TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method unix_timestamp.
  get time.
  data unix_epoch type d value '19700101'.
  data ts type i.
  ts = 86400 * ( sy-datum - unix_epoch ).
  ts = ts + sy-uzeit(2) * 3600.
  ts = ts + sy-uzeit+2(2) * 60.
  ts = ts + sy-uzeit+4(2).
  returning = ts.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_UTIL->_BASE_STRING_URI
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST                        TYPE REF TO /OOP/IF_REQUEST
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _base_string_uri.
  data base_string_uri type string.
  " Create the base string URI using data from the headers
  data scheme type string.
  data domain type string.
  data port type string.
  data path type string.
  scheme = request->get_header( `~uri_scheme_expanded` ).
  translate scheme to lower case.
  domain = request->get_header( `~server_name_expanded` ).
  port = request->get_header( `~server_port_expanded` ).
  path = request->get_header( `~path` ).
  if port <> `80` and port <> `443`. " Port must not be included if it's the default http or https port
    concatenate scheme `://` domain `:` port path into base_string_uri.
  else.
    concatenate scheme `://` domain path into base_string_uri.
  endif.
  returning = base_string_uri.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_UTIL->_ENCODE_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] THE_STRING                     TYPE        STRING
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _encode_string.
  " Encodes a string according to the OAuth percent encoding spec
  " http://tools.ietf.org/html/rfc5849#section-3.6

  data encoded_string type string.

  " Create UTF-8 converter
  data converter type ref to cl_abap_conv_out_ce.
  converter = cl_abap_conv_out_ce=>create( encoding = `UTF-8` ).

  " Process each character separately
  data position type i.
  do strlen( the_string ) times.
    " Get character
    data char type c.
    char = the_string+position(1).
    " Convert character to hexadecimal UTF-8 value
    data char_binary type xstring.
    converter->convert( exporting data = char importing buffer = char_binary ).
    " Copy the hexadecimal UTF-8 value to a string for processing
    data hex_str type string.
    hex_str = char_binary.
    " If the hexadecimal UTF-8 value consist of multiple bytes, process each byte separately
    " Each byte takes up 2 positions in the hexadecimal string
    data bytes type i.
    bytes = strlen( hex_str ) / 2.
    if bytes > 1.
      " Process multiple bytes
      " In this case there is no need to check the _ignored_codes table,
      " because multibyte characters must always be encoded
      data byte_position type i.
      do bytes times.
        " Each byte takes up 2 positions in the hexadecimal string
        data hex_str_part type string.
        hex_str_part = hex_str+byte_position(2).
        byte_position = byte_position + 2.
        " Add the percent encoded hexadecimal value to the encoded string
        concatenate encoded_string `%` hex_str_part into encoded_string.
      enddo.
      byte_position = 0.
    else.
      " Process single bytes
      " Check if the hexadecimal value should be encoded
      read table _ignored_codes with table key table_line = hex_str transporting no fields.
      if sy-subrc = 0.
        " The hexadecimal value should not be encoded, add the character to the encoded string instead
        concatenate encoded_string char into encoded_string.
      else.
        " Add the percent encoded hexadecimal value to the encoded string
        concatenate encoded_string `%` hex_str into encoded_string.
      endif.
    endif.
    position = position + 1.
  enddo.

  returning = encoded_string.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_UTIL->_INIT_IGNORED_CODES
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _init_ignored_codes.
  " Digits
  insert `30` into table _ignored_codes.
  insert `31` into table _ignored_codes.
  insert `32` into table _ignored_codes.
  insert `33` into table _ignored_codes.
  insert `34` into table _ignored_codes.
  insert `35` into table _ignored_codes.
  insert `36` into table _ignored_codes.
  insert `37` into table _ignored_codes.
  insert `38` into table _ignored_codes.
  insert `39` into table _ignored_codes.
  " Uppercase letters
  insert `41` into table _ignored_codes.
  insert `42` into table _ignored_codes.
  insert `43` into table _ignored_codes.
  insert `44` into table _ignored_codes.
  insert `45` into table _ignored_codes.
  insert `46` into table _ignored_codes.
  insert `47` into table _ignored_codes.
  insert `48` into table _ignored_codes.
  insert `49` into table _ignored_codes.
  insert `4A` into table _ignored_codes.
  insert `4B` into table _ignored_codes.
  insert `4C` into table _ignored_codes.
  insert `4D` into table _ignored_codes.
  insert `4E` into table _ignored_codes.
  insert `4F` into table _ignored_codes.
  insert `50` into table _ignored_codes.
  insert `51` into table _ignored_codes.
  insert `52` into table _ignored_codes.
  insert `53` into table _ignored_codes.
  insert `54` into table _ignored_codes.
  insert `55` into table _ignored_codes.
  insert `56` into table _ignored_codes.
  insert `57` into table _ignored_codes.
  insert `58` into table _ignored_codes.
  insert `59` into table _ignored_codes.
  insert `5A` into table _ignored_codes.
  " Lowercase letters
  insert `61` into table _ignored_codes.
  insert `62` into table _ignored_codes.
  insert `63` into table _ignored_codes.
  insert `64` into table _ignored_codes.
  insert `65` into table _ignored_codes.
  insert `66` into table _ignored_codes.
  insert `67` into table _ignored_codes.
  insert `68` into table _ignored_codes.
  insert `69` into table _ignored_codes.
  insert `6A` into table _ignored_codes.
  insert `6B` into table _ignored_codes.
  insert `6C` into table _ignored_codes.
  insert `6D` into table _ignored_codes.
  insert `6E` into table _ignored_codes.
  insert `6F` into table _ignored_codes.
  insert `70` into table _ignored_codes.
  insert `71` into table _ignored_codes.
  insert `72` into table _ignored_codes.
  insert `73` into table _ignored_codes.
  insert `74` into table _ignored_codes.
  insert `75` into table _ignored_codes.
  insert `76` into table _ignored_codes.
  insert `77` into table _ignored_codes.
  insert `78` into table _ignored_codes.
  insert `79` into table _ignored_codes.
  insert `7A` into table _ignored_codes.
  " Reserved characters
  insert `2D` into table _ignored_codes.
  insert `2E` into table _ignored_codes.
  insert `5F` into table _ignored_codes.
  insert `7E` into table _ignored_codes.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method /OOP/CL_OAUTH_UTIL->_RANDOM_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] LENGTH                         TYPE        I
* | [<-()] RETURNING                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
method _random_string.
  data chars type string value `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`.

  data seed type i.
  seed = cl_abap_random=>seed( ).
  data prng type ref to cl_abap_random.
  prng = cl_abap_random=>create( seed = seed ).

  data string type string.
  do length times.
    data rnd type i.
    rnd = prng->intinrange( low = 0 high = 61 ).
    concatenate string chars+rnd(1) into string.
  enddo.

  returning = string.
endmethod.
ENDCLASS.
