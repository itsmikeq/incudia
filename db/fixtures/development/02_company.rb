Incudia::Seeder.quiet do
  Company.seed do |c|
    c.name = Faker::Company.name
    c.description = Faker::HipsterIpsum.words(10)
    c.owner = User.order("RANDOM()").first
  end
end