function qfmore#sources#GitLsFiles#execute(count, pattern) abort
    return qfmore#utils#handle_shell_command_returning_filenames(
    \   a:count,
    \   a:pattern,
    \   ['git', 'ls-files'],
    \)
endfunction
