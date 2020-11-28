FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "#{Faker::Cannabis.strain}-#{n}" }
    description { Faker::Cannabis.health_benefit }
    price { rand(100_000) }
  end
end