# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'

user = User.create!( email: 'malachai@shortjab.com', password: 'please', password_confirmation: 'please' )

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
