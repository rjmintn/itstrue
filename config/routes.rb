Rails.application.routes.draw do
  # get 'stripe/create'
  resources :charges, only: [:new, :create, :downgrade]
  resources :wikis
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end
