; format-ignore

[
 (package_declaration)
 (extend_stmt)
 (action_declaration)
 (activity_declaration)
 (activity_scheduling_constraint)
 (struct_declaration)
 (exec_block)
 (procedural_function)
 (import_class_decl)
 ; procedural_stmt is too large scope,
 ; some sentence inside procedural_stmt could not perform indent
 ; such as procedural_break_stmt
 ; don't use procedural_stmt directly
 (procedural_repeat_stmt)
 (procedural_foreach_stmt)
 (procedural_if_else_stmt)
 (procedural_match_stmt)
 (procedural_compile_if_stmt)
 
 (component_declaration)
 (object_bind_item_or_list)
 (labeled_activity_stmt)
 ; (activity_sequence_block_stmt)
 ; (activity_parallel_stmt)
 ; (activity_schedule_stmt)
 ; (activity_select_stmt)
 ; (activity_match_stmt)
 ; (activity_atomic_block_stmt)
 (activity_bind_item_or_list)
 (symbol_declaration)
 (override_declaration)
 ; (cover_stmt)
 (monitor_declaration)
 (monitor_activity_declaration)
 (labeled_monitor_activity_stmt)
 ; (monitor_activity_sequence_block_stmt)
 ; (monitor_activity_concat_stmt)
 ; (monitor_activity_overlap_stmt)
 ; (monitor_activity_select_stmt)
 ; (monitor_activity_schedule_stmt)
 (monitor_constraint_declaration)
 ; (monitor_constraint_block)
 (enum_declaration)
 (constraint_declaration)
 ; (constraint_block)
 (inline_constraints_or_empty)
 (constraint_body_item)
 ; (unique_constraint_item)
 (covergroup_declaration)
 (inline_covergroup)
 (covergroup_options_or_empty)
 (inline_constraints_or_empty)
 (bins_or_empty)
 (cross_item_or_null)
 (package_body_compile_if_item)
 (action_body_compile_if_item)
 (monitor_body_compile_if_item)
 (component_body_compile_if_item)
 (struct_body_compile_if_item)
 ; (procedural_compile_if_stmt)
 ; (constraint_body_compile_if_item)
 (covergroup_body_compile_if_item)
 (override_compile_if_stmt)
 ; (empty_aggregate_literal)
 (value_list_literal)
 (map_literal)
 (struct_literal)
 (SNPS_SHADOWED)
 (QUOTED_STRING_ITEM) 
 (TRIPLE_QUOTED_STRING_ITEM)
 ] @indent.begin

[
 "else"
 "}"
 ] @indent.branch


