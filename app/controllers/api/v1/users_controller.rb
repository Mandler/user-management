module Api
  module V1
    class UsersController < ActionController::API
      def index
        response = Api::Users::FetchAll.new(params).call
        render response
      end

      def create
        response = Api::Users::Create.new(params).call
        render response
      end

      def destroy
        response = Api::Users::Destroy.new(params).call
        render response
      end
    end
  end
end
