Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :ride_track do
    get :home_page
    get :estimate
  end

  root 'ride_track#home_page'

end
