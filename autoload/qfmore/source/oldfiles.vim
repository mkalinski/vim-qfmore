function qfmore#source#oldfiles#list() abort
    return map(copy(v:oldfiles), function('qfmore#util#map_qf_first_line'))
endfunction
