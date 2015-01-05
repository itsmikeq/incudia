Incudia::Seeder.quiet do
  (1..100).each do
    Interest.seed do |i|
      i.name        = "#{Faker::Company.name} Interest"
      i.description = Faker::HipsterIpsum.words(10).join("\s")
      i.owner       = User.order("RANDOM()").first
      # Add some interested users
    end
  end
  User.all.each do |i|
    Interest.order("RANDOM()").first.users << i
  end
end