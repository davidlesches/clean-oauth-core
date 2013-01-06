
  resources :users

  # oauth routes
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure'            => redirect('/')

  # login logout routes
  match '/login'        => 'sessions#new', as: :login
  match '/logout'       => 'sessions#destroy', as: :logout
  match '/registration' => 'users#new', as: :registration

