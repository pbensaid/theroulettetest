Rails.application.routes.draw do

  root 'surveys#index'
  resources :surveys do
    member do
      get 'results'
    end
  end
  resources :votes

end
