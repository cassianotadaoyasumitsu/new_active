Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :users, only: [:index, :show]

  # Performance routes
  authenticate :user, -> (user) { user.admin? } do
    mount RailsPerformance::Engine, at: 'rails/performance'
  end
end
