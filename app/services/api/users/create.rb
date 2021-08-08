module Api
  module Users
    class Create
      def initialize(params)
        @params = params
      end

      def call
        create_user
      end

      private

      attr_reader :params

      def create_user
        User.create!(user_params)
        response :created, {}
      rescue => e
        response :internal_server_error, {errors: e.message}
      end

      def response(status, json)
        {status: status, json: json}
      end

      def user_params
        params.require(:users).permit(:first_name, :last_name, :email)
      end
    end
  end
end
