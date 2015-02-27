Rails.application.routes.draw do

  resources :surveys do
    member do
      get 'results'
      get 'share'
    end
  end
  resources :votes
  root 'surveys#index'

  resources :pages, :only => :show

  #Custom Error Generating controller
  get "/errors/not_found" => 'errors#not_found'
  get "/errors/server_error" => 'errors#server_error'


end
