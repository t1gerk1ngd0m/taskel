Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  resources :tasks do
  end
  resources :groups

  root  'tasks#index'

  get     'login',  to: 'sessions#new'
  post    'login',  to: 'sessions#create'
  delete  'logout', to: 'sessions#destroy'

end
