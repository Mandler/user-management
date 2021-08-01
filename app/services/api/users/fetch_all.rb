module Api
  module Users
    class FetchAll
      def initialize(params)
        @params = params
      end

      def call
        users_list
      end

      private

      attr_reader :params

      def users_list
        users = User.all.select(:id, :first_name, :last_name, :email)

        case params[:order_by]
        when 'email'
          users = users.order(:email)
        when 'name'
          users = users.order(:first_name, :last_name)
        end

        response :ok, users
      end

      def response(status, json)
        {status: status, json: json}
      end
    end
  end
end
