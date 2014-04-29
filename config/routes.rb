Rails.application.routes.draw do
  devise_for :users
  root :to => "home#index"


  resources :decks

  resources :games, :except => [ :destroy, :update ] do
    resources :players, :only => [ :new, :create, :destroy ]
  end

end
