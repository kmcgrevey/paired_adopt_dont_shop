Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  # resources :leads, path: ''
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets', to: 'pets#pets'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  # post '/pets/:id', to: 'pets#favorite'
  post '/pets/:id', to: 'favorites#favorite' #'/pets/:id' /favorites/:id
  get '/favorites', to: 'favorites#index'
  # delete '/pets/:id', to: 'favorites#destroy'
  patch '/favorites/:pet_id', to: 'favorites#remove' #this needs to be destroy
  delete '/favorites/:pet_id', to: 'favorites#remove_index'
  delete '/favorites', to: 'favorites#remove_all'

  get '/applications/new', to: 'applications#new'
  post '/favorites', to: 'applications#create' #applications
  # get '/applications', to: 'applications#index'
  get '/applications/:id', to: 'applications#show'
  # get '/applications', to: 'applications#index'
  get '/pets/:id/applications', to: 'applications#index'
  post 'pets/:pet_id/applications/:id', to: 'applications#approve'
end
