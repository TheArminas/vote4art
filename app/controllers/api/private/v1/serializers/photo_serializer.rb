module Api
  module Private
    module V1
      module Serializers
        class PhotoSerializer
          include FastJsonapi::ObjectSerializer

          meta do |photo|
            {
              name: photo.name,
              url: photo.url
            }
          end
        end
      end
    end
  end
end
