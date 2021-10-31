function s:getlist(
\   source_name, len_limit = 0, filter_pattern = '', source_args = []
\) abort
    let l:listing = call(qfmore#source#get(a:source_name), a:source_args)

    if !empty(a:filter_pattern)
        call filter(l:listing, qfmore#util#make_filter_regex(a:filter_pattern))
    endif

    if a:len_limit > 0
        let l:listing = l:listing[: a:len_limit]
    endif

    return l:listing
endfunction

function qfmore#qf(
\    source_name, len_limit = 0, filter_pattern = '', source_args = []
\) abort
    call setqflist(
    \   s:getlist(a:source_name, a:len_limit, a:filter_pattern, a:source_args),
    \)
    call setqflist([], 'r', {'title': a:source_name})
endfunction

function qfmore#loc(
\    buf_nr, source_name, len_limit = 0, filter_pattern = '', source_args = []
\) abort
    call setloclist(
    \   a:buf_nr,
    \   s:getlist(a:source_name, a:len_limit, a:filter_pattern, a:source_args),
    \)
    call setloclist(a:buf_nr, [], 'r', {'title': a:source_name})
endfunction
