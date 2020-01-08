require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with description, price and category' do
    product = build(:product)

    expect(product).to be_valid
  end

  it 'is invalid without description' do
    product = build(:product, description: nil)

    expect(product).to_not be_valid
  end

  it 'is invalid without price' do
    product = build(:product, price: nil)

    expect(product).to_not be_valid
  end

  it 'is invalid without category' do
    product = build(:product, category: nil)

    expect(product).to_not be_valid
  end

  it 'return a product with a full description' do
    product = create(:product)

    expect(product.full_description).to eq("#{product.description} - #{product.price}")
  end

  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }
end
