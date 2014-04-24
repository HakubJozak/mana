Mana::Application.routes.draw do

  root :to => "home#index"

  devise_for :users
  resources :decks

  resources :games, :except => [ :destroy, :update ] do
    resources :players, :only => [ :new, :create, :destroy ]
  end



end
