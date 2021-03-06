module Api
  module Private
    module V1
      class Users < Grape::API
        version 'v1', using: :path
          
        prefix :api
        format :json

        rescue_from :all

        helpers Api::Private::V1::Helpers::Auth

        resource :users do
          before do
            authorize
            @c_user = current_user
          end
          desc 'user accepts terms and conditions'
          params do
            requires :accept, type: Boolean
          end
          put :accept_conditions do
            current_user.update_attribute(:terms_and_conditions, params[:accept])
            Api::Private::V1::Serializers::UserSerializer.new(@c_user).serialized_json
          end

          desc 'returns user info'
          get :info do
            Api::Private::V1::Serializers::UserSerializer.new(@c_user).serialized_json
          end
        end
      end
    end
  end
end
