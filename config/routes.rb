Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'ride_track#home'

  namespace :ride_track do
    get :home
    get :price_estimate
  end
end
