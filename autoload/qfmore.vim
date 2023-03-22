if !exists('g:qfmore#default_qf_command_prefix')
    let g:qfmore#default_qf_command_prefix = 'C'
endif

if !exists('g:qfmore#enabled_builtin_sources')
    let g:qfmore#enabled_builtin_sources = [
    \   'GitCommitFiles',
    \   'GitLsFiles',
    \   'OldFiles',
    \   'RecFiles',
    \]
endif

function qfmore#execute_qf(source_name, func_name, count, pattern) abort
    let l:qf_entries = function(a:func_name)(a:count, a:pattern)
    call setqflist(l:qf_entries)
    call setqflist([], 'r', #{title: a:source_name})
    cw
endfunction

function qfmore#create_command(source_name, func_name, options = {}) abort
    let l:command_prefix = get(
    \   a:options,
    \   'qf_command_prefix',
    \   g:qfmore#default_qf_command_prefix,
    \)

    " This is to prevent a typo from breaking the defined command.
    " The command would fail when called, but it's at least consistent.
    let l:command_name = escape(a:source_name, '"\')
    let l:func_name = escape(a:func_name, '"\')

    execute 'command -nargs=? -count'
    \   l:command_prefix .. l:command_name
    \   printf(
    \       'call qfmore#execute_qf("%s", "%s", <count>, <q-args>)',
    \       l:command_name,
    \       l:func_name,
    \   )
endfunction
