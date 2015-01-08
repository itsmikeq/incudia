json.array!(@embedded_contents) do |embedded_content|
  json.extract! embedded_content, :id, :url, :owner_id, :owner_type, :owner_type
  json.url embedded_content_url(embedded_content, format: :json)
end
