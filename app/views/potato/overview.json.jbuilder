json.array!(@context[:overview_table_data]) do |line|
  json.extract!(line,
    :version,
    :tasks,
    :due)
end