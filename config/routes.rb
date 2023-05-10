Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follow
      get :unfollow
    end
  end

  resources :jobs, only: [:index, :new, :create, :destroy]
  # Users routes
  get '/active', to: 'users#active_index', as: 'active_users'
  get '/inactive', to: 'users#inactive_index', as: 'inactive_users'

  # Performance routes
  authenticate :user, -> (user) { user.admin? } do
    mount RailsPerformance::Engine, at: 'rails/performance'
  end
end
