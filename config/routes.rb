Rails.application.routes.draw do

    resources :artisits, only: [:show] do
        resources :songs, only: [:show, :index]
    end
    
  resources :artists
  resources :songs
end
