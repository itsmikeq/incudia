json.array!(@admin_ext_services) do |admin_ext_service|
  json.extract! admin_ext_service, :id, :url
  json.url admin_ext_service_url(admin_ext_service, format: :json)
end
