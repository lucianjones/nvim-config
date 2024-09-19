;extends
(block_mapping
  (block_mapping_pair
    key: (flow_node) @_key (#eq? @_key "shell")
    value: (flow_node) @_value (#eq? @_value "python"))
  (block_mapping_pair
    key: (flow_node) @_run (#any-of? @_run "run")
    value: (block_node
      (block_scalar) @injection.content)
      (#set! injection.language "python")
      (#offset! @injection.content 0 1 0 0)))
