require 'rails_helper'
require_relative '../support/new_customer_form'

RSpec.feature "Customers", type: :feature, js: true do
  it 'Visit the customers index page' do
    visit(customers_path)
    save_and_open_page
    # page.save_screenshot('screenshot.png')
    expect(page.current_path).to eq(customers_path)
  end

  it 'create a new customer' do
    member = create(:member)

    login_as(member, scope: :member)

    visit(new_customer_path)

    expect {
      fill_in('customer_name', with: Faker::Name.name)
      fill_in('customer_email', with: Faker::Internet.email)
      fill_in('customer_address', with: Faker::Address.street_address)

      click_button('Create Customer')
    }.to change { Customer.all.count }.by(1)

    expect(page).to have_content('Customer was successfully created.')
  end

  it 'creates a new customer - Page Object Pattern' do
    new_customer_form = NewCustomerForm.new
    new_customer_form.login.visit_page.fill_in_with(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      address: Faker::Address.street_address
    ).submit

    member = create(:member)

    login_as(member, scope: :member)

    visit(new_customer_path)

    expect {
      fill_in('customer_name', with: Faker::Name.name)
      fill_in('customer_email', with: Faker::Internet.email)
      fill_in('customer_address', with: Faker::Address.street_address)

      click_button('Create Customer')
    }.to change { Customer.all.count }.by(1)

    expect(page).to have_content('Customer was successfully created.')
  end

  it 'Ajax' do
    visit(customers_path)

    click_link('Add Message')

    expect(page).to have_content('Yes!')
  end

  it 'Find' do
    visit(customers_path)

    click_link('Add Message')
    expect(find('#my-div').find('h1')).to have_content('Yes!')
  end
end
