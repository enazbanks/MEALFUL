# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  first_name: 'admin',
  last_name: 'admin',
  age: 18,
  email: 'admin@lewagon.com',
  password: 'admin123',
  admin: true
)

25.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.within(range: 18..99),
    email: Faker::Internet.email
  )
  user.save!(:validate => false)
end

50.times do
  title = "#{Faker::Hipster.word} with #{Faker::Food.dish} & #{Faker::Beer.style}"
  meal = Meal.new(
    name: title,
    description: Faker::Food.description,
    min_size: Faker::Number.within(range: 1..5),
    price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    category: Faker::Food.ingredient,
    location: Faker::Address.city,
    max_size: Faker::Number.within(range: 5..25)
  )
  meal.user = User.all.sample
  if meal.save
    puts "#{meal.name} saved"
  else
    puts "something went wrong"
  end
end

100.times do
  booking = Booking.new(
    date: Faker::Date.between(from: '2020-09-23', to: Date.today),
    price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    status: Faker::Number.within(range: 0..2)
  )
  booking.meal = Meal.all.sample
  size = Faker::Number.within(range: booking.meal.min_size..booking.meal.max_size)
  booking.size = size
  booking.user = User.all.sample
  if booking.save
    rating = Rating.new(
      value: Faker::Number.within(range: 0..5)
    )
    rating.user = booking.user
    rating.booking = booking
    if rating.save
      puts "rating saved"
    else
      puts "rating wrong"
    end
  else
    puts "booking wrong"
  end
end
