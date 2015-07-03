json.array!(@context[:propagations_table_data]) do |line|
  json.extract!(line,
  	:user, 
  	:due, 
  	:key,
  	:status,
  	:target,
  	:prs,
  	:parent,
  	:parent_status,
  	:parent_target)
end
