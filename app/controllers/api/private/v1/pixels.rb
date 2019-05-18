module Api
  module Private
    module V1
      class Pixels < Grape::API
        version 'v1', using: :path
        prefix :api
        format :json

        helpers Api::Private::V1::Helpers::Auth
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!({ messages: e.full_messages }, 400)
        end

        namespace :public do
          before do
            @serializer_options = { meta: {photo: Class.const_get('Photo').last&.url} }
          end
          resource :pixels do
            desc 'returns active pixels'
            get :ready do
              pixs = Pixel.ready
              Api::Private::V1::Serializers::PixelSerializer.new(pixs,  @serializer_options).serialized_json
            end
            desc 'return pixel by init and ready statuses'
            get '/' do
              pixs = Pixel.init_ready
              Api::Private::V1::Serializers::PixelSerializer.new(pixs,  @serializer_options).serialized_json
            end
            desc 'user info by pixel coordinates'
            params do
              requires :x, type: String
              requires :y, type: String
            end
            get :user_info do
              user = Pixel.by_coordinates(params).first.user
              Api::Private::V1::Serializers::UserSerializer.new(user).serialized_json
            end
          end
        end

        resource :pixels do
          before do
            authorize
            @serializer_options = { meta: {photo: Class.const_get('Photo').last&.url} }
          end
          get :last do
            pixel = current_user.pixels.last
            Api::Private::V1::Serializers::PixelSerializer.new(pixel, @serializer_options).serialized_json
          end

          params do
           requires :x, type: Integer
           requires :y, type: Integer
           requires :color, type: String
         end
          post '/' do
            pixel = current_user.pixels.create(params)
            if pixel.persisted?
              Api::Private::V1::Serializers::PixelSerializer.new(Pixel.ready, @serializer_options).serialized_json
            end
          end
        end
      end
    end
  end
end
