Rails.application.routes.draw do

  resources :events

  mount TownCrier::Engine => "/town_crier"
end
