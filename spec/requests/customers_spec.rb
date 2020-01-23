require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! returns 200 ok" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "index JSON 200 ok" do
      get '/customers.json'
      expect(response).to have_http_status(200)

      expect(response.body).to include_json(
        [
          id: 1,
          name: 'Elijah Hodkiewicz',
          email: 'amado@ferryherman.io'
        ]
      )
    end

    it 'show JSON 200 ok' do
      get '/customers/1.json'
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        id: 1
      )
    end

    it 'create - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = {
        "ACCEPT" => "application/json"
      }

      customers_params = attributes_for(:customer)

      post '/customers.json', params: { customer: customers_params }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: customers_params[:name],
        email: customers_params.fetch(:email)
      )
    end

    it 'Update - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = {
        "ACCEPT" => "application/json"
      }

      customer = create(:customer)

      new_name = Faker::Name.name

      patch "/customers/#{customer.id}.json", params: { customer: { name: new_name } }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: new_name,
        email: customer.email
      )
    end

    it 'Delete - JSON' do
      member = create(:member)
      login_as(member, scope: :member)

      headers = {
        "ACCEPT" => "application/json"
      }

      customer = create(:customer)

      expect { delete "/customers/#{customer.id}.json", headers: headers }.to change { Customer.count }.by(-1)

      expect(response).to have_http_status(204)
    end

    it 'show - RSPEC puro + JSON 200 ok' do
      get '/customers/1.json'

      response_body = JSON.parse(response.body)

      expect(response_body.fetch('id')).to be_kind_of(Integer)
      expect(response_body.fetch('name')).to be_kind_of(String)
      expect(response_body.fetch('email')).to be_kind_of(String)
    end

    it 'JSON Schema' do
      get '/customers/1.json'
      expect(response.body).to match_response_schema('customer')
    end
  end
end
