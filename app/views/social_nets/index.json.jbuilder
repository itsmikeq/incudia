json.array!(@social_nets) do |social_net|
  json.extract! social_net, :id, :name, :api_url
  json.url social_net_url(social_net, format: :json)
end
