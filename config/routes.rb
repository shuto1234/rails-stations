Rails.application.routes.draw do
  root to: 'movies#index'
  get '/' => 'movies#index', as: 'movies'
  get 'movies/:id' => 'movies#show', as: 'movies_id'

  get 'admin/movies' => 'admin/movies#index', as: 'admin_movies_index'
  get 'admin/movies/new', as: 'admin_movies_new'
  post 'admin/movies' => 'admin/movies#create', as: 'admin_movies_create'
  get 'admin/movies/:id/edit' => 'admin/movies#edit', as: 'admin_movies_edit'
  put 'admin/movies/:id' => 'admin/movies#update', as: 'admin_movies_update'
  delete 'movies/:id' => 'admin/movies#destroy', as: 'admin_movies_destroy'

  get 'sheets' => 'sheets#index', as: 'sheets'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
