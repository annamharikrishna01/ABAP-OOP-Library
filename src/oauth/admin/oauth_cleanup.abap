report /oop/oauth_cleanup.

data oauth_service type ref to /oop/cl_oauth_service.
create object oauth_service.
oauth_service->cleanup( ).
write: / text-t01.