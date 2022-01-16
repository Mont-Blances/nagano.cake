Rails.application.routes.draw do
  namespace :admin do
    resources:items, only: [:create, :edit, :index, :update, :show, :new]
  end
  
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # belongs_to :genre
end
