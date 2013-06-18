report /oop/oauth_create_client.

parameters pa_name type /oop/oa_client_name obligatory.
parameters pa_desc type /oop/oa_client_description obligatory.
parameters pa_comp type /oop/oa_client_company obligatory.
parameters pa_url type /oop/oa_client_url obligatory.

data oauth_service type ref to /oop/cl_oauth_service.
create object oauth_service.

data oauth_client type ref to /oop/cl_oauth_client.
oauth_client = oauth_service->new_client( name = pa_name description = pa_desc company = pa_comp url = pa_url ).
if oauth_client is not bound.
  write: / text-t01 color col_negative intensified on.
  return.
endif.

data id type /oop/oa_client_id.
id = oauth_client->id( ).
data secret type /oop/oa_client_secret.
secret = oauth_client->secret( ).
data name type /oop/oa_client_name.
name = oauth_client->name( ).
data description type /oop/oa_client_description.
description = oauth_client->description( ).
data company type /oop/oa_client_company.
company = oauth_client->company( ).
data url type /oop/oa_client_url.
url = oauth_client->url( ).

write: text-t02 color col_positive intensified on.
write: /.
write /(100): text-t03 color col_heading.
write: / id color col_total, /.
write /(100): text-t04 color col_heading.
write: / secret color col_total, /.
write /(100): text-t05 color col_heading.
write: / name, /.
write /(100): text-t06 color col_heading.
write: / description, /.
write /(100): text-t07 color col_heading.
write: / company, /.
write /(100): text-t08 color col_heading.
write: / url, /.