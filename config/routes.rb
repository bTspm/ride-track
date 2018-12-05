Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'ride_tracks#home'

  namespace :ride_tracks do
    get :home
    get :price_estimate
  end

  namespace :currencies do
    get :home
    get :convert
    get :history
  end
end
