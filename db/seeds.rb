# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(name: "Gandalf",
  email: "pilgrim@valinor.com",
  password: 'shadowfax',
  password_confirmation: 'shadowfax',
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

User.create!(name: "Starbuck",
  email: "starbuck@galactica.com",
  password: 'sosayweall',
  password_confirmation: 'sosayweall',
  activated: true,
  activated_at: Time.zone.now)

106.times do |n|
  name = Faker::StarWars.character
  email = "farmer-#{n+1}@tatooine.com"
  password = "helpmeobiwan"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Superhero.power
  content = Faker::Hipster.sentences(3).join(' ')
  users.each do |user| 
    user.posts.create!(title: title, content: content) 
  end
end

