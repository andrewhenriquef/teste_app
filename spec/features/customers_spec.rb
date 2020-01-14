require 'rails_helper'

RSpec.feature "Customers", type: :feature, js: true do
  it 'Visit the customers index page' do
    visit(customers_path)
    save_and_open_page
    # page.save_screenshot('screenshot.png')
    expect(page.current_path).to eq(customers_path)
  end
end
