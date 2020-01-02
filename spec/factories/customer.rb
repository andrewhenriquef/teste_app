FactoryBot.define do
  factory :customer, aliases: [:user_customer] do
    name Faker::Name.name
    email Faker::Internet.email
  end
end
