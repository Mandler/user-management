require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do
    get 'Loading all users' do
      tags 'Users'
      consumes 'application/json'

      response '200', 'All Users' do
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'email' ]
      }

      response '201', 'user created' do
        let(:user) { { users: { first_name: 'Rafael', last_name: 'Petrovic', email: 'example@example.com' } } }
        run_test!
      end

      response '500', 'invalid request' do
        let(:user) { { first_name: 'anything' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string }
          },
          required: [ 'id', 'first_name', 'last_name', 'email' ]

        let(:id) { create(:user).id }
        run_test!
      end

      response '500', 'user not found' do
        let(:id) { 'example' }
        run_test!
      end
    end
  end
end
