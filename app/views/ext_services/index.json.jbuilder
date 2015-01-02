json.array!(@ext_services) do |ext_service|
  json.extract! ext_service, :id, :social_net_id, :consumer_id, :consumer_type
  json.url ext_service_url(ext_service, format: :json)
end
