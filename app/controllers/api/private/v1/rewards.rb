module Api
  module Private
    module V1
      class Rewards < Grape::API
        version 'v1'
        prefix :api
        format :json

        helpers Api::Private::V1::Helpers::Auth

        resource :rewards do
          before do
            authorize
            @c_user = current_user
          end
          desc 'rewards user with pixels'
          params do
            requires :lat, type: String
            requires :long, type: String
            requires :hash, type: String
          end
          post :reward do
            if Reward.confirm(params, @c_user.id)
              Api::Private::V1::Serializers::UserSerializer.new(@c_user).serialized_json
            else
              error!({ messages: "Veiksmas negalimas" }, 401)
            end
          end
        end
      end
    end
  end
end
