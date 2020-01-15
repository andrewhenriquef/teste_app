require 'rails_helper'

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

  it 'Ajax' do
    visit(customers_path)

    click_link('Add Message')

    expect(page).to have_content('Yes!')
  end
end
