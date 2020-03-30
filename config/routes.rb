Rails.application.routes.draw do

  get "/shelters", to: 'shelters#index'
  get "/shelters/new", to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get "/shelters/:id", to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  get "/shelters/:id/pets/new", to: 'pets#new'
  get '/shelters/:id/pets', to: 'pets#show_index'

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  delete "/pets/:id", to: "pets#destroy"
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'

  patch '/favorites/:pet_id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:id', to: 'favorites#destroy'
  delete '/favorites/remove_favorite/:pet_id', to: 'favorites#remove_favorite'
  delete '/favorites', to: 'favorites#destroy_all'

  get 'applications/new', to: 'applications#new'
  get 'applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
  get '/pets/:id/applications', to: 'applications#index'

end
