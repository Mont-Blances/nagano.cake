Rails.application.routes.draw do
  namespace :admin do
  resources :genres, only: [:create, :edit, :index, :update]
  end
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   has_many items
end
