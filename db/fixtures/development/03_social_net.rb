Incudia::Seeder.quiet do
  SocialNet.seed do |c|
    c.name = Faker::Company.name
    c.description = Faker::HipsterIpsum.words(10)
    c.api_url = Faker::Internet.http_url
  end
end