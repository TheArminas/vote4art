module Api
  module Params
    module Pixels
      extend Grape::API::Helpers

      params :pixel do
        requires :color, type: Integer
        requires :x, type: String
        requires :y, type: String
      end
    end
  end
end
