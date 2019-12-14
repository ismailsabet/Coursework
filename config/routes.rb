Rails.application.routes.draw do

  resources :playlists

  root 'home#home'

  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  post 'songs/search_songs', to: 'songs#search_songs'

  resources :songs, only: [:index, :show, :destroy, :create, :new]

end
