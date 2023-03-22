if exists('s:do_once')
    finish
endif

let s:do_once = 1

function s:qfmore_setup() abort
    for l:source_name in g:qfmore#enabled_builtin_sources
        let l:func_name = printf('qfmore#sources#%s#execute', l:source_name)
        call qfmore#create_command(l:source_name, l:func_name)
    endfor
endfunction

call s:qfmore_setup()
