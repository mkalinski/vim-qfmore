function qfmore#sources#GitCommitFiles#execute(count, pattern) abort
    let l:commit_name = empty(a:pattern) ? 'HEAD' : a:pattern

    return qfmore#utils#handle_shell_command_returning_filenames(
    \   a:count,
    \   '',
    \   [
    \       'git',
    \       'diff-tree',
    \		'--no-commit-id',
    \		'--name-status',
    \		'--relative',
    \		'-r',
    \		l:commit_name,
    \   ],
    \   {lines ->
    \       map(lines, function('qfmore#sources#GitCommitFiles#_convert'))
    \   }
    \)
endfunction

function qfmore#sources#GitCommitFiles#_convert(idx, line) abort
    let l:idx_past_space = match(a:line, '\S', 1)

    return #{lnum: 1, type: a:line[0], filename: a:line[l:idx_past_space :]}
endfunction
