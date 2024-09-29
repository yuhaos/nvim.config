; format-ignore
[
 ; ... refers to the portion that this indent query will have effects on
 (checker_declaration)
 (class_declaration)
 (interface_class_declaration)
 (package_declaration)
 (constraint_declaration)
 (function_declaration)
 (generate_region)
 (task_declaration)
 (modport_declaration)
 (property_declaration)
 (sequence_declaration)
 (covergroup_declaration)
 (initial_construct)
 (always_construct)
 (final_construct)
 (conditional_statement)
 (loop_statement)
 (case_statement)
 (clocking_declaration)
 (enum_base_type)
 (specify_block)
 (type_declaration)
 (class_constructor_declaration)
 (seq_block)
 (par_block)
 "{"
 ] @indent.begin

[
 "end"
 "endchecker"
 "endclass"
 "endpackage"
 "endfunction"
 "endtask"
 "endproperty"
 "endsequence"
 "endgroup"
 "endcase"
 "endclocking"
 "endspecify"
 "endgenerate"
 "else"
 "}"
 ] @indent.branch @indent.end

[
 (tf_port_list)
 (list_of_ports)
 (list_of_port_declarations)
 (list_of_arguments)
 (list_of_actual_arguments)
 ] @indent.begin

; ([
;   (function_declaration)
; ] @indent.align
; (#set! indent.open_delimiter "(")
; (#set! indent.close_delimiter ")")
; )

