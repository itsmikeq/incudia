json.array!(@interests) do |interest|
  json.extract! interest, :id, :name, :description, :type, :owner_id, :owner_type
  json.url interest_url(interest, format: :json)
end
