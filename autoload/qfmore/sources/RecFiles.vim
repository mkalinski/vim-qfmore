function qfmore#sources#RecFiles#execute(count, pattern) abort
    let l:command = ['rg', '--sort', 'path', '--files']

    if !empty(a:pattern)
        call extend(l:command, ['-g', a:pattern])
    endif

    return qfmore#utils#handle_shell_command_returning_filenames(
    \   a:count,
    \   '',
    \   l:command,
    \)
endfunction
