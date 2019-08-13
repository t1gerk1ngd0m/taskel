Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  root  'tasks#index'
  resources :tasks do
  end

  get     'login',  to: 'sessions#new'
  post    'login',  to: 'sessions#create'
  delete  'logout', to: 'sessions#destroy'

end
