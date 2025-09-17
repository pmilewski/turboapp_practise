# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


150.times do
  Movie.create(title: Faker::Movie.unique.title)
end unless Movie.any?


100.times do
  Comment.create(body: Faker::Quote.famous_last_words)
end unless Comment.any?


100.times do
  Post.create(title: Faker::Music.band, body: Faker::Quote.famous_last_words)
end unless Post.any?


100.times do
  Artist.create(name: Faker::Artist.name)
end unless Artist.any?

100.times do
  Person.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65)
  )
end unless Person.any?
