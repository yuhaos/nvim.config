((comment) @injection.content
           (#set! injection.language "comment"))

((SNPS_SHADOWED) @injection.content
           (#set! injection.language "txt"))

((target_code_exec_block
  (exec_kind) 
  .
  (id) @exec_kind_type
  .
  (string_literal
    (QUOTED_STRING
      (QUOTED_STRING_ITEM) @injection.content)))
 (#eq? @exec_kind_type "SV")
 (#set! injection.language "systemverilog")
 )

((target_code_exec_block
  (exec_kind) 
  .
  (id) @exec_kind_type
  .
  (string_literal
    (QUOTED_STRING
      (QUOTED_STRING_ITEM) @injection.content)))
 (#any-of? @exec_kind_type "C" "DPI-C" "DPI_C")
 (#set! injection.language "cpp")
 )

((target_code_exec_block
  (exec_kind) 
  .
  (id) @exec_kind_type
  .
  (string_literal
    (TRIPLE_QUOTED_STRING
      (TRIPLE_QUOTED_STRING_ITEM) @injection.content)))
 (#eq? @exec_kind_type "SV")
 (#set! injection.language "systemverilog")
 )

((target_code_exec_block
  (exec_kind) 
  .
  (id) @exec_kind_type
  .
  (string_literal
    (TRIPLE_QUOTED_STRING
      (TRIPLE_QUOTED_STRING_ITEM) @injection.content)))
 (#any-of? @exec_kind_type "C" "DPI-C" "DPI_C")
 (#set! injection.language "cpp")
 )
