require 'rails_helper'

RSpec.describe Customer, type: :model do

  #basic Mixtures, what factory bot && girl does behind the scenes
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

  it 'transient attributes' do
    # atributos que existem no momento de criação do objecto mas que não interferem
    # no objeto de fato, eles não existem depois que o objeto foi criado, eles ajudam a criar logicas
    # para as fabricas

    customer = create(:customer_default, upcased: true)

    expect(customer.full_name).to eq("Sr. #{customer.name.upcase}")

    customer = create(:customer_default, upcased: false)

    expect(customer.full_name).to eq("Sr. #{customer.name}")
  end

  it 'Traits example' do
    customer = create(:customer_vip, :male)

    expect(customer.gender).to eq('M')

    customer = create(:customer_vip, :female)

    expect(customer.gender).to eq('F')

    # factory with traits
    # can compose factory with a lot of traits

    customer = create(:customer_male)

    expect(customer.gender).to eq('M')

    customer = create(:customer_female)

    expect(customer.gender).to eq('F')
  end

  # using rails time helper

  it 'travel to' do
    travel_to Time.zone.local(2004, 11, 24, 1, 4, 44) do
      @customer = create(:customer_vip, :male)
    end

    expect(@customer.created_at).to eq(Time.zone.local(2004, 11, 24, 1, 4, 44))
    expect(@customer.created_at).to be < Time.now

    expect(@customer.gender).to eq('M')

    customer = create(:customer_vip, :female)

    expect(customer.gender).to eq('F')

    # factory with traits
    # can compose factory with a lot of traits

    customer = create(:customer_male)

    expect(customer.gender).to eq('M')

    customer = create(:customer_female)

    expect(customer.gender).to eq('F')
  end
end
