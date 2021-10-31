function qfmore#source#recfiles#list(additional_args = []) abort
    return map(
    \   qfmore#util#from_systemlist(
    \       qfmore#setting#get('source_recfiles_cmd') + a:additional_args
    \   ),
    \   function('qfmore#util#map_qf_first_line'),
    \)
endfunction
