module Api
  module Private
    module V1
      class Users < Grape::API
        version 'v1', using: :path
        prefix :api
        format :json

        helpers Api::Private::V1::Helpers::Auth

        resource :users do
          desc 'user accepts terms and conditions'
          params do
            requires :accept, type: Boolean
          end
          put :accept_conditions do
            if authorize
              current_user.update_attribute(:terms_and_conditions, params[:terms_and_conditions])
              Api::Private::V1::Serializers::UserSerializer.new(current_user).serialized_json
            end
          end
        end
      end
    end
  end
end
