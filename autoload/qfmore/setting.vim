let s:DEFAULTS = {
\   'qf_command_prefix': 'C',
\   'loc_command_prefix': 'L',
\   'source_recfiles_cmd': ['find', '.'],
\}

function qfmore#setting#get(name) abort
    try
        return get(g:, 'qfmore_' .. a:name, s:DEFAULTS[a:name])
    catch /^Vim\%((\a\+)\)\=:E716/
        throw qfmore#util#fmt_err(
        \   'SettingNotExists',
        \   'Setting does not exist: ' .. a:name,
        \)
    endtry
endfunction
