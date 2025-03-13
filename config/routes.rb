Rails.application.routes.draw do
  devise_for :users

  root to: 'movies#index'
  get '/' => 'movies#index', as: 'movies'
  get 'movies/:id' => 'movies#show', as: 'movies_id'
  get 'movies/:id/reservation' => 'movies#reservation', as: 'reservation_sheets'


  get 'movies/:movie_id/schedules/:schedule_id/reservations/new' => 'reservations#new', as: 'reservations_new'
  post 'reservations' => 'reservations#create', as: 'reservations_create'

  
  get 'sheets' => 'sheets#index', as: 'sheets'

  # config/routes.rb
  resources :reservations, only: [:create] 

  get 'admin/movies' => 'admin/movies#index', as: 'admin_movies_index'
  get 'admin/movies/new', as: 'admin_movies_new'
  post 'admin/movies' => 'admin/movies#create', as: 'admin_movies_create'
  get 'admin/movies/:id' => 'admin/movies#show', as: 'admin_movies_show'
  get 'admin/movies/:id/edit' => 'admin/movies#edit', as: 'admin_movies_edit'
  put 'admin/movies/:id' => 'admin/movies#update', as: 'admin_movies_update'
  delete 'movies/:id' => 'admin/movies#destroy', as: 'admin_movies_destroy'

  
  get 'admin/schedules' => 'admin/schedules#index', as: 'admin_schedules'
  get 'admin/movies/:id/schedules/new' => 'admin/schedules#new', as: 'admin_schedules_new'
  post 'admin/movies/:id/schedules' => 'admin/schedules#create', as: 'admin_schedules_create'
  get 'admin/schedules/:id' => 'admin/schedules#edit', as: 'admin_schedules_edit'
  put 'admin/schedules/:id' => 'admin/schedules#update', as: 'admin_schedules_update'
  delete 'admin/schedules/:id' => 'admin/schedules#destroy', as: 'admin_schedules_destroy'

  get 'admin/reservations' => 'admin/reservations#index', as: 'admin_reservations'
  get 'admin/reservations/new' => 'admin/reservations#new', as: 'admin_reservations_new'
  post 'admin/reservations' => 'admin/reservations#create', as: 'admin_reservations_create'
  get 'admin/reservations/:id' => 'admin/reservations#show', as: 'admin_reservations_show'
  put 'admin/reservations/:id' => 'admin/reservations#update', as: 'admin_reservations_update'
  delete 'admin/reservations/:id' => 'admin/reservations#destroy', as: 'admin_reservations_destroy'


  get 'admin/users/' => 'admin/users#index', as: 'admin_users'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
