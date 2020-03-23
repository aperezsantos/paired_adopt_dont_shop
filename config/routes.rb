Rails.application.routes.draw do

  get "/shelters", to: 'shelters#index'
  get "/shelters/new", to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get "/shelters/:id", to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get "shelters/:id/pets/new", to: 'pets#new'
  get '/shelters/:id/pets', to: 'pets#show_index'

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  delete "/pets/:id", to: "pets#destroy"
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
end
