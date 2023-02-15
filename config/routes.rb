Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :delete], controllers: {
    sessions: "users/sessions",
  }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"

  resources :tasks do
  end
end
