function qfmore#source#gitls#list(additional_args = []) abort
    return map(
    \   qfmore#util#from_systemlist(['git', 'ls-files'] + a:additional_args),
    \   function('qfmore#util#map_qf_first_line'),
    \)
endfunction
