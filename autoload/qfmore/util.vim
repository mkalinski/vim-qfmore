function qfmore#util#fmt_err(err_name, message) abort
    return printf('qfmore:%s: %s', a:err_name, a:message)
endfunction

function qfmore#util#make_filter_regex(filter_pattern) abort
    return {key, val -> l:val.filename =~ a:filter_pattern}
endfunction

function qfmore#util#map_qf_first_line(key, val) abort
    return {'filename': a:val, 'lnum': 1}
endfunction

function qfmore#util#from_systemlist(cmd) abort
    let l:listing = systemlist(a:cmd)

    if v:shell_error
        echoerr join(l:listing, "\n")
        return []
    endif

    return l:listing
endfunction

function qfmore#util#define_commands(source_name) abort
    if !qfmore#source#exists(a:source_name)
        throw qfmore#util#fmt_err(
        \   'SourceNotExists',
        \   'Source does not exist: ' .. a:source_name,
        \)
    endif

    execute 'command! -nargs=? -count '
    \   .. qfmore#setting#get('qf_command_prefix') .. a:source_name
    \   "call qfmore#qf('" .. a:source_name .. "', <count>, <args>) | cw"
    execute 'command! -nargs=? -count '
    \   .. qfmore#setting#get('loc_command_prefix') .. a:source_name
    \   "call qfmore#loc(0, '" .. a:source_name .. "', <count>, <args>) | lw"
endfunction
