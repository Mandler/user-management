module Api
  module Users
    class Show
      def initialize(params)
        @params = params
      end

      def call
        get_user
      end

      private

      attr_reader :params

      def get_user
        response :ok, User.select(:id, :first_name, :last_name, :email).find(params[:id])
      rescue => e
        response :internal_server_error, {errors: e.message}
      end

      def response(status, json)
        {status: status, json: json}
      end
    end
  end
end
