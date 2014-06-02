Rails.application.routes.draw do
  get 'cards/index'

  devise_for :users
  root :to => "home#index"

  resources :decks

  resources :games, except: [ :destroy, :update ] do
    resources :cards, only: [ :index ]
    resources :players, only: [ :new, :create, :destroy ]
  end

end
