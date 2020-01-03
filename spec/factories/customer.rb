FactoryBot.define do
  factory :customer, aliases: [:user_customer] do
    transient do
      upcased false
    end

    # utilize blocks when there are dinamic attributes
    name { Faker::Name.name }
    email { Faker::Internet.email }

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

    # this is a callback
    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end

    # another kinds of callbacks
    # after(:build), runs after the object be created in memory
    # before(:create), runs before the object be persisted in database
    # after(:create), runs after the object be persisted in database
  end
end
