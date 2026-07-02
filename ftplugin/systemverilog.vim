" Vim filetype plugin file
" Language: SystemVerilog

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setlocal formatoptions< comments< commentstring<"

setlocal formatoptions-=t formatoptions+=croql
setlocal commentstring=//\ %s
setlocal comments=s1:/*,mb:*,ex:*/,://

let b:match_words = '\<begin\>:\<end\>,' ..
      \ '\<class\>:\<endclass\>,' ..
      \ '\<function\>:\<endfunction\>,' ..
      \ '\<task\>:\<endtask\>,' ..
      \ '\<module\>:\<endmodule\>,' ..
      \ '\<interface\>:\<endinterface\>,' ..
      \ '\<package\>:\<endpackage\>,' ..
      \ '\<program\>:\<endprogram\>,' ..
      \ '\<case\>\|\<casez\>\|\<casex\>:\<endcase\>,' ..
      \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>'
let b:undo_ftplugin ..= " | unlet! b:match_words"

" Make match-up skip delimiters and keywords in comments and strings without
" relying on tree-sitter matchup queries or Vim syntax highlighting.
if !exists("*SystemVerilogMatchSkip")
  function! SystemVerilogMatchSkip(lnum, col) abort
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

let b:match_skip = 'SystemVerilogMatchSkip(line("."), col("."))'
let b:undo_ftplugin ..= " | unlet! b:match_skip"

let &cpo = s:cpo_save
unlet s:cpo_save

