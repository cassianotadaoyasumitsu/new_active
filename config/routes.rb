Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :users, only: [:index, :show, :edit, :update] #do
  #   member do
  #     get :follow
  #     get :unfollow
  #   end
  # end

  resources :jobs, only: [:index, :new, :create, :destroy]
  # Users routes
  get '/manager', to: 'users#manager_index', as: 'manager_users'
  get '/inactive', to: 'users#inactive_index', as: 'inactive_users'
  get '/master', to: 'users#master_index', as: 'master_users'

  # Performance routes
  authenticate :user, -> (user) { user.admin? } do
    mount RailsPerformance::Engine, at: 'rails/performance'
  end
end
