report /oop/oauth_create_permission.

parameters pa_clid type /oop/oa_perm-client_id obligatory value check.
parameters pa_reid type /oop/oa_perm-resource_id obligatory value check.
parameters pa_crea type /oop/oa_perm-create_allowed as checkbox.
parameters pa_read type /oop/oa_perm-read_allowed as checkbox.
parameters pa_upda type /oop/oa_perm-update_allowed as checkbox.
parameters pa_dele type /oop/oa_perm-delete_allowed as checkbox.
parameters pa_head type /oop/oa_perm-head_allowed as checkbox.

data oauth_permission type ref to /oop/cl_oauth_permission.
create object oauth_permission
  exporting
    client_id      = pa_clid
    resource_id    = pa_reid
    create_allowed = pa_crea
    read_allowed   = pa_read
    update_allowed = pa_upda
    delete_allowed = pa_dele
    head_allowed   = pa_head.

data oauth_permission_repo type ref to /oop/if_oauth_permission_repo.
oauth_permission_repo = /oop/cl_oauth_repo_factory=>permission_repo( ).
oauth_permission_repo->create( oauth_permission ).
commit work.

write: text-t01 color col_positive intensified on.