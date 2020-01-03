FactoryBot.define do
  factory :customer, aliases: [:user_customer] do
    transient do
      upcased false
    end

    name Faker::Name.name
    email Faker::Internet.email

    trait :male do
      gender 'M'
    end

    trait :female do
      gender 'F'
    end

    # inheritance
    factory :customer_vip do
      vip true
      days_to_pay 30
    end

    factory :customer_default do
      vip false
      days_to_pay 15
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end
