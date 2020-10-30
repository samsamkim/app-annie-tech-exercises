Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :connections, only: [:index] 
  post '/connections_filter' => 'connections#index'

end
