# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

8.times do
  Record.create(artist: Faker::RockBand.name,    
  album_title: Faker::Book.title,
  year: Faker::Number.between(1920, 1980) )
end

5.times do
	User.create(email: Faker::Internet.email, password: "123456", password_confirmation: "123456" )
end

user = User.create(email: "sample@gmail.com", password: "123456", password_confirmation: "123456" )

[1, 3, 5].each do |n|
	RecordsUser.create(user_id: user.id, record_id: n, condition: "unopened", rating: rand(1..10), favorite: rand(5) > 3)
end

[2, 3, 4, 6].each do |n|
	RecordsUser.create(user_id: User.first.id, record_id: n, condition: "unopened", rating: rand(1..10), favorite: rand(5) > 3)
	RecordsUser.create(user_id: User.first.id+1, record_id: n, condition: "unopened", rating: rand(1..10), favorite: rand(5) > 3)
end

[1,7].each do |n|
	RecordsUser.create(user_id: User.first.id+3, record_id: n, condition: "unopened", rating: rand(1..10), favorite: rand(5) > 3)
	RecordsUser.create(user_id: User.first.id+2, record_id: n, condition: "unopened", rating: rand(1..10), favorite: rand(5) > 3)
end
