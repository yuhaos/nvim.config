; Keywords

[
 "abstract"
 "as"
 "atomic"
 "bind"
 "bins"
 "compile"
 "concat"
 "const"
 "constraint"
 "continue"
 "cross"
 "default"
 "do"
 "dynamic"
 "eventually"
 "exec"
 "export"
 "extend"
 "file"
 "ignore_bins"
 "illegal_bins"
 "join_branch"
 "join_first"
 (activity_join_none)
 "join_select"
 "list"
 "map"
 "monitor"
 "override"
 "parallel"
 "private"
 "protected"
 "public"
 "pure"
 "rand"
 "randomize"
 "replicate"
 "resource"
 "schedule"
 "select"
 "sequence"
 "set"
 "solve"
 "state"
 "super"
 "target"
 "type"
 "typedef"
 "unique"
 "with"
 "yield"
 (resource_ref_field_type)
 ] @keyword

[
 "action"
 "activity"
 "array"
 "bit"
 "buffer"
 "class"
 "component"
 "covergroup"
 "coverpoint"
 "enum"
 "float32"
 "float64"
 "package"
 "pool"
 "stream"
 "string"
 "struct"
 "symbol"
 "void"
 (exec_kind)
 ] @keyword.type

[
 "function"
 "task"
 ] @keyword.function

"return" @keyword.return

[
 "forall"
 "foreach"
 "repeat"
 "while"
 ] @keyword.repeat

[
 "if"
 "iff"
 "else"
 "match"
 "break"
 ] @keyword.conditional

[
 "dist"
 "has"
 "in"
 (unary_operator)
 (logic_operator)
 (binary_operator)
 (assign_op)
] @operator

[
  "["
  "]"
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

[
 "assert"
 "cover"
 "disable"
 "inout"
 "input"
 "output"
 "ref"
 "static"
 ] @keyword.modifier

[
 "import"
 ] @keyword.import

(function_prototype (id) @function)
(function_ref_path (id) @function)

; @type is red, we don't want red in code
; @label is yellow, using yellow insteand
; @keyword.type is the same as keyword
[
 (data_type)
 (casting_type)
 ] @type

[
 (number)
 (bool_literal)
 (null_ref)
 ] @number

(instance_override "instance" @keyword)
(target_code_exec_block (id) @keyword)
(import_function (id) @keyword)
(target_template_function (id) @keyword)

(package_id_path                (id)*            @type)
(package_import_alias           (id)             @type)
(action_declaration             (id)             @type)
(object_ref_field               (id)             @type)
(struct_declaration             (id)             @type)
(import_class_decl (id) @type)
(covergroup_type_instantiation . (id) @type . (id) @variable)
(component_declaration          (id)             @type)
(enum_declaration               (id)             @type)
(monitor_declaration            (id)             @type)
(package_import_pattern         (type_identifier (type_identifier_elem)* @type))
(type_identifier_elem) @type

; label
(activity_stmt (id) @label . ":")
(activity_join_branch (id)* @label)
(activity_action_traversal_stmt (id) @label . ":" )
(activity_replicate_stmt (id) (id) @label)
; (cover_stmt (id) @label)
(monitor_activity_stmt (id) @label)
(covergroup_coverpoint (id) @label)
(covergroup_cross (id)* @label)

(action_instantiation (id)* @variable)
(activity_action_traversal_stmt . (id) @variable)
(function_parameter (id) @variable)
(procedural_data_instantiation  (id) @variable)
(procedural_repeat_stmt (id) @variable)
(procedural_foreach_stmt (id)* @variable)
(component_pool_declaration (id) @variable)
(component_path_elem (id) @variable)
(object_bind_item (id) @variable)
(activity_repeat_stmt (id)* @variable)
(activity_foreach_stmt (id)* @variable)
(activity_replicate_stmt (id) @variable)
(symbol_declaration (id) @variable)
(symbol_param (id) @variable)
(monitor_instantiation (id)* @variable)
(monitor_activity_monitor_traversal_stmt (id) @variable)
(monitor_constraint_declaration (id) @variable)

(generic_type_param_decl (id) @type)
(category_type_param_decl (id) @type)

(value_param_decl (id) @variable)
(constraint_declaration (id) @variable)
(foreach_constraint_item (id)* @variable)
(forall_constraint_item (id)* @variable)
(covergroup_declaration (id) @variable)
(inline_covergroup (id) @variable)

(component_pool_declaration     (id)             @variable)
(data_instantiation             (id)             @variable)
(procedural_assignment_stmt (expression) @variable)
(hierarchical_id) @variable
(enum_item (id) @variable)
(covergroup_port (id) @variable)
(covergroup_option (id) @variable)
(covergroup_portmap (id) @variable)
(covergroup_coverpoint_binspec (id) @variable)
(coverpoint_bins (id) @variable)
(symbol_call (id) @function)
(struct_literal_item (id) @variable)


((member_path_elem) @variable
                    (#not-any-of? @variable "this" "comp"))
((member_path_elem) @variable.builtin
                    (#any-of? @variable.builtin "this" "comp"))

(comment) @comment @spell
