function qfmore#utils#filter_lines_by_pattern(lines, pattern) abort
    return filter(a:lines, {idx, val -> val =~# a:pattern})
endfunction

function qfmore#utils#map_filenames_to_qf_entries(filenames) abort
    return map(a:filenames, {idx, val -> #{lnum: 1, filename: val}})
endfunction

function qfmore#utils#handle_shell_error(command, output_lines) abort
    if v:shell_error && !empty(a:output_lines)
        echohl ErrorMsg
        echo 'Shell command failed:' a:command
        echo join(a:output_lines, "\n")
        echohl None
        return 1
    endif

    return 0
endfunction

function qfmore#utils#handle_shell_command_returning_filenames(
\   count,
\   pattern,
\   command,
\   convert_function = function('qfmore#utils#map_filenames_to_qf_entries'),
\) abort
    let l:output_lines = systemlist(a:command)

    if qfmore#utils#handle_shell_error(a:command, l:output_lines)
        return []
    endif

    if !empty(a:pattern)
        call qfmore#utils#filter_lines_by_pattern(l:output_lines, a:pattern)
    endif

    if a:count > 0
        let l:output_lines = l:output_lines[: a:count - 1]
    endif

    return a:convert_function(l:output_lines)
endfunction
