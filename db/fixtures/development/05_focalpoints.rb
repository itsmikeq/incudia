Incudia::Seeder.quiet do
  (1..10).each do
    Focalpoint.seed do |c|
      c.name        = "#{Faker::Company.name} Focal Point"
      c.description = Faker::HipsterIpsum.words(10)
      c.owner       = User.order("RANDOM()").first
      c.area        = Area.order("RANDOM()").first
    end
  end
  User.all.each do |a|
    Focalpoint.order("RANDOM()").first.users << a
  end

end