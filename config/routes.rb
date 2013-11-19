DataQualityCollector::Application.routes.draw do
  resources :metrics

  resources :dimensions

  resources :apps

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end