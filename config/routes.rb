Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  resources :groups, except: [:show] do
    resources :tasks
  end

  root  'groups#index'

  get     'login',  to: 'sessions#new'
  post    'login',  to: 'sessions#create'
  delete  'logout', to: 'sessions#destroy'

end
