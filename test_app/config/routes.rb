TestApp::Application.routes.draw do
  resources :nifs
  match 'javascript', :to => "static#javascript"
  root :to => "static#index"
end
