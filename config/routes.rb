Rails.application.routes.draw do
  resources :properties,  only: :index
end
