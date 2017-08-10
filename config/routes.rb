Rails.application.routes.draw do
  # get 'stripe/create'
  resources :charges, only: [:new, :create, :edit]
  resources :wikis
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end
