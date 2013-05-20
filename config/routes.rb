
  resources :users

  # oauth routes
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure'            => redirect('/')

  # login logout vanity routes
  match '/login'    => 'sessions#new', as: :login
  match '/logout'   => 'sessions#destroy', as: :logout
  match '/register' => 'users#new', as: :register


