Rails.application.routes.draw do
  
  root  'tasks#index'

  get '/tasks', to: 'tasks#index'
  get '/tasks/new', to: 'tasks#new'
  post '/tasks', to: 'tasks#create'
  get '/tasks/:id', to: 'tasks#show'
  get '/tasks/:id/edit', to: 'tasks#edit'
  patch '/tasks/:id', to: 'tasks#update'

end
