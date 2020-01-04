require 'rails_helper'

RSpec.describe Order, type: :model do
  # associations
  it "tem um pedido com customer associado" do
    order = create(:order)

    expect(order.customer).to be_kind_of(Customer)
  end

  it "sobrescrevendo o customer default" do
    customer = create(:customer)
    order = create(:order, customer: customer)

    expect(order.customer).to be_kind_of(Customer)
  end

  it 'create_list example' do
    orders = create_list(:order, 3, description: 'teste')

    orders.map do |order|
      expect(order.description).to eq('teste')
    end

    expect(orders.count).to eq 3
  end
end
