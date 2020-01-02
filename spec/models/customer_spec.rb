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

  it 'Factory inheritance' do
    customer = create(:customer_default)

    expect(customer.vip).to be false
    expect(customer.days_to_pay).to eq 15

    customer = create(:customer_vip)

    expect(customer.vip).to be true
    expect(customer.days_to_pay).to eq 30

    customer = create(:customer)

    expect(customer.vip).to be nil
    expect(customer.days_to_pay).to be nil
  end

  it 'attributes_for example' do
    # extract attributes from an factory
    # an hash with all values of the object: example: {:name=>"Claude Connelly", :email=>"ricardaorn@brakuslind.org", :vip=>true, :days_to_pay=>30}
    # is it good to test apis values
    attrs = attributes_for(:customer_vip)
  end
end
