require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'GET #index' do
    context 'without records in table' do
      before do
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response is empty' do
        json_response = JSON.parse(response.body)
        expect(json_response).to be_empty
      end
    end

    context 'with records in table' do
      before do
        create(:user)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.first.keys).to match_array(['id', 'first_name', 'last_name', 'email'])
      end
    end
  end

  describe 'POST #create' do
    context 'with required params' do
      let(:valid_attributes) { { users: { first_name: 'Rafael', last_name: 'Petrovic', email: 'example@example.com' } } }

      before do
        post :create, params: valid_attributes
      end

      it 'returns :ok status' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect(User.all.count).to eq 1
      end
    end

    context 'without required params' do
      before do
        post :create, params: { user: { first_name: "Rafael" } }
      end

      it 'returns error' do
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'does not create a user' do
        expect(User.all.count).to eq 0
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user model' do
      before do
        user = create(:user)
        post :destroy, params: { id: user.id }
      end

      it 'returns :destroy status' do
        expect(response).to have_http_status(:ok)
      end

      it 'removes a user' do
        expect(User.all.count).to eq 0
      end
    end
  end
end
