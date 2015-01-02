# Generated with RailsBricks
# Initial seed file to use with Devise User Model


# Test user accounts
(1..50).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      username: "user#{i}",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end
  

