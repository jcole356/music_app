Rails.application.routes.draw do
  resources :albums, except: :new do
    resources :tracks, only: :new
  end

  resources :bands do
    resources :albums, only: :new
  end
  
  resources :tracks, except: :new
  resource :session, only: [:create, :new, :destroy]
  resources :users,  only: [:create, :new, :show]
end
