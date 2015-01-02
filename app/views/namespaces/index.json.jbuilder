json.array!(@namespaces) do |namespace|
  json.extract! namespace, :id, :name, :description, :owner_id, :owner_type, :type
  json.url namespace_url(namespace, format: :json)
end
