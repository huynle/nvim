if exists('g:loaded_selection_helper')
	finish
endif

let g:loaded_selection_helper = 1

" Returns visually selected text
function! VisualSelection() abort "{{{
	try
		let a_save = @a
		silent! normal! "ay
		" silent! normal! gv"ay
		return substitute(escape(@a, '\/'), '\n', '\\n', 'g')
	finally
		let @a = a_save
	endtry
endfunction "}}}


" function! VisualSelection()
"   " Why is this not a built-in Vim script function?!
"   let [line_start, column_start] = getpos("'<")[1:2]
"   let [line_end, column_end] = getpos("'>")[1:2]
"   let lines = getline(line_start, line_end)
"   if len(lines) == 0
"     return ''
"   endif
"   let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
"   let lines[0] = lines[0][column_start - 1:]
"   return join(lines, "\n")
" endfunction
