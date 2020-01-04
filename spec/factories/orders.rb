FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número: #{n}" }
    # another way to write the association
    # here we can change what factory will be used
    # association :customer, factory: :customer
    # association :customer, factory: :customer_vip
    customer
  end
end
