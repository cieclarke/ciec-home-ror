Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'
  get '/work', to: 'work#index'
  get '/photos', to: 'photos#index'
  get '/notes', to: 'notes#index'
end
