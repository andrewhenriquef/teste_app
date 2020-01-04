FactoryBot.define do
  factory :customer, aliases: [:user_customer] do
    transient do
      upcased false
      qtt_orders 3
    end

    # utilize blocks when there are dinamic attributes
    name { Faker::Name.name }
    email { Faker::Internet.email }

    # generate some data sequentially

    # starts in this number
    # sequence(:email, 25) {|n| "my-email-#{n}@gmail.com"}

    # sequence(:email, 'a') {|n| "my-email-#{n}@gmail.com"} => create with 'a', 'b', 'c'
    # sequence(:email) do |n|
    #   "my-email-#{n}@gmail.com"
    # end

    trait :male do
      gender 'M'
    end

    trait :female do
      gender 'F'
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
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
    factory :customer_with_orders, traits: [:male, :with_orders]

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
