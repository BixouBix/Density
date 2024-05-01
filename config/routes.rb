Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  match "home", :to => "home#index", :via => :get
  root to: "home#index"

  resources :students, only: %i[index create] do
    member do
      post :enroll
      post :grade_quarter
    end
  end
  resources :courses, only: [:create] do
    collection do
      get :admin_index
      get :student_index
    end
  end
end
