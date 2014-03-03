Rails.application.routes.draw do

  root :to => "start#index"
  get 'start/:action', :controller=>:start

  resources :events

  mount TownCrier::Engine => "/town_crier"
end
