TestApp::Application.routes.draw do
  resources :nifs
  root :to => "static#index"
end
