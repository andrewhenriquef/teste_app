require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  context 'as a guest' do
    describe '#index' do
      it 'responds successfully' do
        get :index
        expect(response).to be_success
      end

      it 'returns a 200 response status' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to have_http_status('200')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context 'as a member' do
    describe '#show' do
      before :all do
        @member = create(:member)
        @customer = create(:customer)
      end

      it 'returns a 302 (not authorized)' do
        get :show, params: { id: @customer.id }

        expect(response).to have_http_status(302)
      end

      it 'returns a 200 to authenticated user' do
        sign_in @member

        get :show, params: { id: @customer.id }
        expect(response).to have_http_status(:ok)
      end

      it 'render :show template' do
        sign_in @member

        get :show, params: { id: @customer.id }
        expect(response).to render_template(:show)
      end

      it 'with valid attributes' do
        customer_params = attributes_for(:customer_vip)
        sign_in @member

        expect {
          post :create, params: { customer: customer_params }
        }.to change(Customer, :count).by(1)
      end

      it 'with invalid attributes' do
        customer_params = attributes_for(:customer_vip, address: nil)
        sign_in @member

        expect {
          post :create, params: { customer: customer_params }
        }.to_not change(Customer, :count)
      end

      it 'flash notice successfully created' do
        customer_params = attributes_for(:customer_vip)
        sign_in @member

        post :create, params: { customer: customer_params }

        expect(flash[:notice]).to match /successfully created/
      end

      it 'content-type request' do
        customer_params = attributes_for(:customer_vip)
        sign_in @member

        post :create, format: :json, params: { customer: customer_params }

        expect(response.content_type).to match /application\/json/
      end

      # shoulda matchers to test routing
      it { should route(:get, '/customers').to(action: :index) }
      it { is_expected.to route(:get, '/customers').to(action: :index) }
    end
  end
end
