module Api
  class Base < Grape::API
    mount Api::Private::V1::Base
  end
end
