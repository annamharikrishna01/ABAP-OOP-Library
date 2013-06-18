report /oop/oauth_maintenance.

parameters pa_clie type c radiobutton group r01.
parameters pa_perm type c radiobutton group r01.
parameters pa_requ type c radiobutton group r01.
parameters pa_toke type c radiobutton group r01.
selection-screen skip.
parameters pa_tmpi type c radiobutton group r01.
parameters pa_tmpa type c radiobutton group r01.
parameters pa_tmpt type c radiobutton group r01.

data oauth_tab type se16n_tab.
case 'X'.
  when pa_clie.
    oauth_tab = '/OOP/OA_CLIENTS'.
  when pa_perm.
    oauth_tab = '/OOP/OA_PERM'.
  when pa_requ.
    oauth_tab = '/OOP/OA_REQUESTS'.
  when pa_tmpa.
    oauth_tab = '/OOP/OA_TMP_AUTH'.
  when pa_tmpi.
    oauth_tab = '/OOP/OA_TMP_INIT'.
  when pa_tmpt.
    oauth_tab = '/OOP/OA_TMP_TOKE'.
  when pa_toke.
    oauth_tab = '/OOP/OA_TOKENS'.
  when others.
    leave program.
endcase.
set parameter id 'DTB' field oauth_tab.
call transaction 'SE16N'.