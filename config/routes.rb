Rails.application.routes.draw do
  devise_for :users,
    controllers: {registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#index"
  get '/users/:id', to: 'users#show', as: 'user'

  resources :posts, only: %i[new create index show] do
    resources :photos, only: %i[create]
  end

end
