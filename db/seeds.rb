# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.within(range: 18..99),
    email: Faker::Internet.email
  )
  user.save!(:validate => false)
end

50.times do
  meal = Meal.new(
    name: Faker::Hipster.sentence,
    description: Faker::Food.description,
    size: Faker::Number.within(range: 1..25),
    price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    category: Faker::Food.ingredient,
    location: Faker::Address.city
  )
  meal.user = User.all.sample
  if meal.save
    puts "#{meal.name} saved"
  else
    puts "something went wrong"
  end
end
