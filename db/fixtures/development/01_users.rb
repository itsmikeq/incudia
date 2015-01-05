# Test user accounts
Incudia::Seeder.quiet do
  (1..200).each do |i|
    User.seed do |u|
      u.email                 = "user#{i}@example.com"
      u.username              = "user#{i}"
      u.password              = "1234"
      u.password_confirmation = "1234"
    end

    puts "#{i} test users created..." if (i % 5 == 0)

  end
  User.all.each do |user|
    user.skip_confirmation!
  end
end
