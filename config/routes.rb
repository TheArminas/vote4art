Rails.application.routes.draw do
  mount Api::Private::V1::Pixels => '/'
  devise_for :users,
             path: '',
             defaults: { format: :json },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
end
