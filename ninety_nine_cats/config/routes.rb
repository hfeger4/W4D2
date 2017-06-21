Rails.application.routes.draw do

  resources :cats
  resources :cat_rental_requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
