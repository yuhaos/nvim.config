" Vim filetype plugin file
" Language:	PSS
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 22
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
" Copied from c.vim directly

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Using line continuation here.
let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setl fo< com< ofu< cms< def< inc<"

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" These options have the right value as default, but the user may have
" overruled that.
setlocal commentstring& define& include&

" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
  setlocal ofu=ccomplete#Complete
endif

" Set 'comments' to format dashed lists in comments.
" Also include ///, used for Doxygen.
 setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:///,://

" Make match-up skip delimiters in PSS comments and strings without relying on
" tree-sitter matchup queries or Vim syntax highlighting.
if !exists("*PssMatchSkip")
  function! PssMatchSkip(lnum, col) abort
    let l:in_block_comment = v:false
    let l:target_lnum = a:lnum
    let l:target_idx = a:col - 1

    for lnum in range(1, l:target_lnum)
      let l:line = getline(lnum)
      let l:line_len = strlen(l:line)
      let l:limit = lnum == l:target_lnum ? min([l:line_len, a:col]) : l:line_len
      let l:idx = 0
      let l:in_string = v:false

      while l:idx < l:limit
        if lnum == l:target_lnum && l:idx >= l:target_idx
          return l:in_block_comment || l:in_string
        endif

        let l:pair = strpart(l:line, l:idx, 2)

        if l:in_block_comment
          if l:pair ==# "*/"
            let l:in_block_comment = v:false
            let l:idx += 2
          else
            let l:idx += 1
          endif
          continue
        endif

        if l:in_string
          if strpart(l:line, l:idx, 1) ==# "\\"
            let l:idx += 2
          elseif strpart(l:line, l:idx, 1) ==# '"'
            let l:in_string = v:false
            let l:idx += 1
          else
            let l:idx += 1
          endif
          continue
        endif

        if l:pair ==# "//"
          if lnum == l:target_lnum && l:target_idx >= l:idx
            return v:true
          endif
          break
        elseif l:pair ==# "/*"
          let l:in_block_comment = v:true
          if lnum == l:target_lnum && l:target_idx >= l:idx
            return v:true
          endif
          let l:idx += 2
        elseif strpart(l:line, l:idx, 1) ==# '"'
          let l:in_string = v:true
          if lnum == l:target_lnum && l:target_idx >= l:idx
            return v:true
          endif
          let l:idx += 1
        else
          let l:idx += 1
        endif
      endwhile
    endfor

    return v:false
  endfunction
endif

let b:match_skip = 'PssMatchSkip(line("."), col("."))'
let b:undo_ftplugin ..= " | unlet! b:match_skip"

" Win32 and GTK can filter files in the browse dialog
if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
  if &ft == "cpp"
    let b:browsefilter = "C++ Source Files (*.cpp, *.c++)\t*.cpp;*.c++\n" ..
	  \ "C Header Files (*.h)\t*.h\n" ..
	  \ "C Source Files (*.c)\t*.c\n"
  elseif &ft == "ch"
    let b:browsefilter = "Ch Source Files (*.ch, *.chf)\t*.ch;*.chf\n" ..
	  \ "C Header Files (*.h)\t*.h\n" ..
	  \ "C Source Files (*.c)\t*.c\n"
  else
    let b:browsefilter = "C Source Files (*.c)\t*.c\n" ..
	  \ "C Header Files (*.h)\t*.h\n" ..
	  \ "Ch Source Files (*.ch, *.chf)\t*.ch;*.chf\n" ..
	  \ "C++ Source Files (*.cpp, *.c++)\t*.cpp;*.c++\n"
  endif
  if has("win32")
    let b:browsefilter ..= "All Files (*.*)\t*\n"
  else
    let b:browsefilter ..= "All Files (*)\t*\n"
  endif
  let b:undo_ftplugin ..= " | unlet! b:browsefilter"
endif

let b:man_default_sects = '3,2'

let &cpo = s:cpo_save
unlet s:cpo_save
