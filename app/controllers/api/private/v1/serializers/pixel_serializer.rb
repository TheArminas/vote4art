module Api
  module Private
    module V1
      module Serializers
        class PixelSerializer
          include FastJsonapi::ObjectSerializer

          attributes :id, :x, :y, :color
          # dubluoja per visus irasus
          # meta do |pixel|
          #   {
          #     photo: Class.const_get('Photo').last&.url
          #   }
          # end
        end
      end
    end
  end
end

