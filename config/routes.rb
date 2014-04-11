DataQualityCollector::Application.routes.draw do
  resources :subjective_assessments

  resources :values

  resources :metric_values

  resources :dimension_values

  resources :app_values

  resources :metrics

  resources :dimensions

  resources :apps

  root :to => "apps#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end