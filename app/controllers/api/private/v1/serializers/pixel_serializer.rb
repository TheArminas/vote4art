module Api
  module Private
    module V1
      module Serializers
        class PixelSerializer
          include FastJsonapi::ObjectSerializer

          attributes :id, :x, :y, :color
        end
      end
    end
  end
end

