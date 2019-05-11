Rails.application.routes.draw do
  mount Api::Private::V1::Pixels => '/'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
              #  omniauth_callbacks: 'users/omniauth_callbacks'
             }
end
