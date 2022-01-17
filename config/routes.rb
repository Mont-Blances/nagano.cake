Rails.application.routes.draw do

 # 顧客用ルート

   #homesコントローラ
  root to: "public/homes#top"
  get 'about' => 'public/homes#abuot'

  devise_for :customers,skip: [:passwords,], controllers: {
  　registrations: "public/registrations",
  　sessions: 'public/sessions'
  }

  scope module: :public do
    #cutomersコントローラ
   get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customers_unsubscribe'
   patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
   get 'customers/my_page' => 'customers#show'
   get 'customers/edit' => 'customers#edit'
   patch 'customers/update' => 'customers#update'

    #ordersコントローラ
   post 'orders/confirm' => 'orders#confirm', as: 'orders_confirm'
   get 'orders/thank' => 'orders#thank'
   resources :orders, only: [:create, :new, :index, :show]

    #itemsコントローラ
   resources :items, only: [:index, :show]

    #cart_itemsコントローラ
   resources :cart_items, only: [:index, :create, :update, :destroy]
   delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'

    #deriveriesコントローラ
   resources :deriveries, only: [:index, :create, :destroy, :edit, :update]
  end



 # 管理者用ルート
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }
  
  namespace :admins do
   root :to => 'homes#top'
   resources :customers, only: [:index, :edit, :update, :show]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:show, :index, :new, :create, :edit, :update]
   resources :orders, only: [:index, :show, :update]
   resources :order_items, only: [:update]
  end

end
