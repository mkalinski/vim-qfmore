function qfmore#source#recfiles#list(additional_args = []) abort
    let l:command = get(g:, 'qfmore_source_recfiles_cmd', ['find', '.'])
    return map(
    \   qfmore#util#from_systemlist(l:command + a:additional_args),
    \   function('qfmore#util#map_qf_first_line'),
    \)
endfunction
