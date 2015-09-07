puts 'SETTING UP DEFAULT USER LOGIN 1'

user = User.create!( email: 'malachai@shortjab.com', password: 'promoteliving', password_confirmation: 'promoteliving' )
user.add_role :admin

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'New user created: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'This is your email: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'Login & change this password: ' << user.password

puts 'SETTING UP DEFAULT USER LOGIN 2'

user = User.create!( email: 'matt@promoteliving.com', password: 'promoteliving', password_confirmation: 'promoteliving' )
user.add_role :admin

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'New user created: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'This is your email: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'Login & change this password: ' << user.password

puts 'SETTING UP DEFAULT USER LOGIN 3'

user = User.create!( email: 'brad@promoteliving.com', password: 'promoteliving', password_confirmation: 'promoteliving' )
user.add_role :admin

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'New user created: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'This is your email: ' << user.email

puts '------------'
puts '------------'
puts '------------'
puts '------------'

puts 'Login & change this password: ' << user.password
