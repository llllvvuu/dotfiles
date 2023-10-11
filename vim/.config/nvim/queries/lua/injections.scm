;; extends
((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments (string content: _ @injection.content)))
  (#eq? @_vimcmd_identifier "exec_lua")
  (#set! injection.language "lua"))
