report /oop/oauth.

parameters pa_main type c radiobutton group r01.
parameters pa_clie type c radiobutton group r01.
parameters pa_perm type c radiobutton group r01.
selection-screen skip.
parameters pa_clea type c radiobutton group r01.

case 'X'.
  when pa_main.
    submit /oop/oauth_maintenance via selection-screen and return.
  when pa_clie.
    submit /oop/oauth_create_client via selection-screen and return.
  when pa_perm.
    submit /oop/oauth_create_permission via selection-screen and return.
  when pa_clea.
    submit /oop/oauth_cleanup via selection-screen and return.
  when others.
    leave program.
endcase.