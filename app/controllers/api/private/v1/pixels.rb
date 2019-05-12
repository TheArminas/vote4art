module Api
  module Private
    module V1
      class Pixels < Grape::API
        version 'v1', using: :path
        prefix :api
        format :json

        resource :pixels do
          desc 'returns active pixels'
          get :ready do
            pixs = Pixel.all
            Api::Private::V1::Serializers::PixelSerializer.new(pixs).serialized_json
          end

          desc 'return pixel by init and ready statuses'
          get '/' do
            pixs = Pixel.init_ready
            Api::Private::V1::Serializers::PixelSerializer.new(pixs).serialized_json
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

          get :last do
            pixel = User.last.pixels.last
            Api::Private::V1::Serializers::PixelSerializer.new(pixel).serialized_json
          end

          params do
           requires :x, type: Integer
           requires :y, type: Integer
           requires :color, type: String
         end
          post '/' do
            User.last.pixels.create(params)
          end
        end
      end
    end
  end
end