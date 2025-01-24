Rails.application.routes.draw do
  get 'reservations/new'
  get 'sheet/index'
  get 'sheet/show'
  get 'sheet/edit'
  # get movie_reservation_path(@movie)

  namespace :admin do
    resources :movies do 
      resources :schedules, only:  [:create, :new]
    end
    resources :schedules, only: [:index, :update, :destroy]
  end

  get 'admin/schedules/:id' => "admin/schedules#edit"
  post 'admin/schedules/:id' => "admin/schedules#edit"

  # post 'admin/movies/:id/schedule/new' => "admin/schedule#create"

  resources :sheets

  resources :movies do
    member do
      get 'reservation', to: 'movies#reservation'
    end

    resources :schedules do
      resources :reservations, only: [:new]
    end
  end

  resources :reservations, only: [:create]

  # get "/movies/:movie_id/reservation" => "movies#reservation"  
  # get "/movies/:movie_id/schedules/:schedule_id/reservations/new" => "rezevation#new"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
