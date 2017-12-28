Rails.application.routes.draw do
  resources :edges
  resources :tokens
  resources :websites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
