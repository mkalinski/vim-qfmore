function qfmore#sources#OldFiles#execute(count, pattern) abort
    let l:oldfiles = copy(v:oldfiles)

    if !empty(a:pattern)
        call qfmore#utils#filter_lines_by_pattern(l:oldfiles, a:pattern)
    endif

    if a:count > 0
        let l:oldfiles = l:oldfiles[: a:count - 1]
    endif

    return qfmore#utils#map_filenames_to_qf_entries(l:oldfiles)
endfunction
