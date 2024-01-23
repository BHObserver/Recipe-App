Rails.application.routes.draw do
  get 'foods/index'
  get 'public_recipes/index'
  get 'recipes/index'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'home#index' # Adjust the root path according to your setup

  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  get '/foods', to: 'foods#index', as: 'foods'

end
