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


200.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
    phone: Faker::PhoneNumber.phone_number,
    description: Faker::Lorem.paragraph
  )
end unless Customer.any?

unless List.any?
  todo_list = List.create!(name: "TODO")
  List.create!(name: "In progress")
  List.create!(name: "Done")

  5.times do
    todo_list.tasks.create!(name: Faker::Name.name, body: Faker::Lorem.paragraph(sentence_count: 1))
  end
end
