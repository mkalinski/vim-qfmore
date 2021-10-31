let s:sources = {}

function qfmore#source#exists(source_name) abort
    return has_key(s:sources, a:source_name)
endfunction

function qfmore#source#get(source_name) abort
    try
        return s:sources[a:source_name]
    catch /^Vim\%((\a\+)\)\=:E716/
        throw qfmore#util#fmt_err(
        \   'SourceNotExists',
        \   'Source does not exist: ' .. a:source_name,
        \)
    endtry
endfunction

function qfmore#source#register(source_name, SourceFunc) abort
    if qfmore#source#exists(a:source_name)
        throw qfmore#util#fmt_err(
        \   'SourceAlreadyExists',
        \   'Source already exists: ' .. a:source_name,
        \)
    endif

    if a:source_name !~# '^[A-Z][A-Za-z]*$'
        throw qfmore#util#fmt_err(
        \   'SourceNameInvalid',
        \   'Source name is not valid: ' .. a:source_name,
        \)
    endif

    if type(a:SourceFunc) != v:t_func
        throw qfmore#util#fmt_err(
        \   'SourceInvalid',
        \   printf(
        \       'Source %s is not valid funcref: %s',
        \       a:source_name,
        \       a:SourceFunc
        \   ),
        \)
    endif

    let s:sources[a:source_name] = a:SourceFunc
endfunction

function qfmore#source#define_commands_for_all() abort
    for l:source_name in keys(s:sources)
        call qfmore#util#define_commands(l:source_name)
    endfor
endfunction
