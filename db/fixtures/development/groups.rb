Incudia::Seeder.quiet do
  (1..100).each do
    Group.seed do |i|
      i.name        = "#{Faker::Company.name} Group"
      i.description = Faker::HipsterIpsum.words(10)
      i.owner       = User.order("RANDOM()").first
      # Add some interested users
    end
  end
  User.all.each do |i|
    Group.order("RANDOM()").first.members << i
  end
end