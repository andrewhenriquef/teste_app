require 'rails_helper'

RSpec.describe Customer, type: :model do

  #basic fixtures, what factory bot && girl does behind the scenes
  # fixtures :all #this call all fixtures
  fixtures :customers

  it 'Create a customer using fixtures' do
    customer = customers(:andrew)

    expect(customer.full_name).to eq('Sr. Andrew')
  end

  it 'Create another customer using factory bot' do
    # aliases
    customer = create(:user_customer) # or create(:customer)

    expect(customer.full_name).to eq("Sr. #{customer.name}")
    expect(customer.full_name).to start_with('Sr. ')
  end

  it { expect { create(:customer) }.to change { Customer.all.size }.by(1) }
end
