Incudia::Seeder.quiet do
  (1..10).each do
    Area.seed do |c|
      c.name        = "#{Faker::Company.name} Area"
      c.description = Faker::HipsterIpsum.words(10)
      c.owner       = User.order("RANDOM()").first
    end
  end
  User.all.each do |a|
    Area.order("RANDOM()").first.users << a
  end

end