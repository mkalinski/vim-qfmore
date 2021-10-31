if get(g:, 'qfmore_plugin_loaded', 0)
    finish
endif

let g:qfmore_plugin_loaded = 1

call qfmore#source#register(
\   'OldFiles',
\   function('qfmore#source#oldfiles#list'),
\)
call qfmore#source#register(
\   'RecFiles',
\   function('qfmore#source#recfiles#list'),
\)
call qfmore#source#register(
\   'GitLs',
\   function('qfmore#source#gitls#list'),
\)
