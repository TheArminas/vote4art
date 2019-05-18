Rails.application.routes.draw do
  mount Api::Private::V1::Pixels => '/'
  mount Api::Private::V1::Users => '/'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               
             },
             controllers: {
               sessions: 'api/private/v1/auth',
             }
  devise_scope :user do
    get '/auth/:provider', to: 'api/private/v1/auth#fb'
    post '/api/v1/signup', to: 'api/private/v1/registrations#create'
  end
end
