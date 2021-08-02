module Api
  module Users
    class Destroy
      def initialize(params)
        @params = params
      end

      def call
        destroy_user
      end

      private

      attr_reader :params

      def destroy_user
        User.find(params[:id]).destroy
        response :ok, {}
      rescue => e
        response :internal_server_error, {errors: e.message}
      end

      def response(status, json)
        {status: status, json: json}
      end
    end
  end
end
