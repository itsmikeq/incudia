json.array!(@social_nets_users) do |social_nets_user|
  json.extract! social_nets_user, :id, :user_id, :social_net_id
  json.url social_nets_user_url(social_nets_user, format: :json)
end
