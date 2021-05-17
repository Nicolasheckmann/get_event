# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
10.times do |i|
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::TvShows::GameOfThrones.quote, email: Faker::Name.first_name+"@yopmail.com", encrypted_password: Faker::Crypto.sha1)
  puts "#{i+1} users created"
end

Event.destroy_all
10.times do |i|
  Event.create!(start_date: Faker::Date.between(from: '2021-09-23', to: '2021-11-25'), duration: 60, title: Faker::Science.scientist, description: Faker::Lorem.paragraph(sentence_count: 2), price: Faker::Number.within(range: 1..1000), location: Faker::Tea.variety, admin: User.all.sample)
  puts "#{i+1} events created"
end

Attendance.destroy_all
User.all.each_with_index do |user, i|
  Attendance.create!(attendee: user, event: Event.all.sample, stripe_customer_id: Faker::Crypto.sha1)
  puts "#{i+1} attendances created"
end
Event.all.each_with_index do |event, i|
  Attendance.create!(attendee: User.all.sample, event: event, stripe_customer_id: Faker::Crypto.sha1)
  puts "#{i+1} attendances created"
end