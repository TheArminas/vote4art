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

        before do
          unless route.settings[:auth] && route.settings[:auth][:disabled]  
          authorize
          @cuser = current_user;
          end
          @serializer_options = { meta: {photo: '/bg_1558904364523.png'} }
        end

        namespace :public do
            resource :pixels do
            desc 'returns active pixels'
            route_setting :auth, disabled: true
            get :ready do
              Api::Private::V1::Serializers::PixelSerializer.new(
                Pixel.ready,
                @serializer_options
              ).serialized_json
            end
            desc 'return pixel by init and ready statuses'
            get '/' do
              pixs = Pixel.init_ready
              Api::Private::V1::Serializers::PixelSerializer.new(
                pixs,
                @serializer_options
              ).serialized_json
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
          get :last do
            pixel = @cuser.pixels.last
            Api::Private::V1::Serializers::PixelSerializer.new(pixel, @serializer_options).serialized_json
          end

          params do
           requires :x, type: Integer
           requires :y, type: Integer
           requires :color, type: String
          end
          post '/' do
            error!({ messages: "Išnaudotas pikseliu limitas" }, 406)

            # if @cuser && (@cuser.available_pixel + @cuser.pix_rew ) > 0  
            # pixel = @cuser.pixels.create(params)
            # if pixel.persisted?
            #   Api::Private::V1::Serializers::PixelSerializer.new(Pixel.ready, @serializer_options).serialized_json
            # end
            # else
            #   if @cuser.present?
            #     error!({ messages: "Išnaudotas pikseliu limitas" }, 406)
            #   else
            #     error!({ messages: "Autorizacija privaloma" }, 401)
            #   end
            # end
          end
        end
      end
    end
  end
end
