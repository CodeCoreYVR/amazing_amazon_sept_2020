# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all()

1000.times do
  created_at = Faker::Date.backward(days: 365 * 5)

  Product.create({
    title: Faker::Commerce.product_name,
    description: Faker::Hacker.say_something_smart,
    price: Faker::Commerce.price(range: 0..10_000.00),
    created_at: created_at,
    updated_at: created_at,
  })
end

puts Cowsay.say("Created #{Product.count} products", :dragon)
