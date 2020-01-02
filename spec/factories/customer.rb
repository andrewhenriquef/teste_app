FactoryBot.define do
  factory :customer, aliases: [:user_customer] do
    name Faker::Name.name
    email Faker::Internet.email

    # inheritance
    factory :customer_vip do
      vip true
      days_to_pay 30
    end

    factory :customer_default do
      vip false
      days_to_pay 15
    end
  end
end
