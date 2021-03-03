Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/flickr/albums', to: 'flickr#albums'
  get '/flickr/photos/:albumid', to: 'flickr#photos'
  get '/flickr/recentphotos/:count', to: 'flickr#recentphotos'
  get '*path', to: 'home#index'
end
