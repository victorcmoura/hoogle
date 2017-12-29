Rails.application.routes.draw do
  resources :edges
  resources :tokens
  resources :websites
  root 'websites#homepage'
  get '/search', to: 'edges#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
