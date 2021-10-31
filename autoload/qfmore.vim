function s:getlist(
\   source_name, len_limit = 0, filter_pattern = '', source_args = []
\) abort
    let l:listing = call(qfmore#source#get(a:source_name), a:source_args)

    if !empty(a:filter_pattern)
        call filter(l:listing, qfmore#util#make_filter_regex(a:filter_pattern))
    endif

    if a:len_limit > 0
        " a:len_limit - 1 because vimscript indices are 0-based, but inclusive
        let l:listing = l:listing[: a:len_limit - 1]
    endif

    return l:listing
endfunction

function qfmore#qf(source_name, len_limit = 0, filter_pattern = '', ...) abort
    call setqflist(
    \   s:getlist(a:source_name, a:len_limit, a:filter_pattern, a:000),
    \)
    call setqflist([], 'r', {'title': a:source_name})
endfunction

function qfmore#loc(
\    buf_nr, source_name, len_limit = 0, filter_pattern = '', ...
\) abort
    call setloclist(
    \   a:buf_nr,
    \   s:getlist(a:source_name, a:len_limit, a:filter_pattern, a:000),
    \)
    call setloclist(a:buf_nr, [], 'r', {'title': a:source_name})
endfunction
