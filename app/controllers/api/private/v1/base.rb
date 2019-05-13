module Api
  module Private
    module V1
      class Base < Grape::API
        mount Api::Private::V1::Pixels
        mount Api::Private::V1::Users
      end
    end
  end
end
