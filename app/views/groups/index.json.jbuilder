json.array!(@groups) do |group|
  json.extract! group, :id, :name, :description, :owner_id, :owner_type, :visibility_level
  json.url group_url(group, format: :json)
end
