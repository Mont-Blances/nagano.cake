Rails.application.routes.draw do

 # 顧客用ルート

  devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
   #homesコントローラ
  root to: "homes#top"
  get 'homes/about' => 'homes#about'

    #cutomersコントローラ
   get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customers_unsubscribe'
   patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
   get 'customers/my_page' => 'customers#show'
   get 'customers/my_page/edit' => 'customers#edit'
   patch 'customers/update' => 'customers#update'

    #ordersコントローラ
   post 'orders/confirm' => 'orders#confirm', as: 'orders_confirm'
   get 'orders/thank' => 'orders#thank'
   resources :orders, only: [:create, :new, :index, :show ,:confirm]

    #itemsコントローラ
   resources :items, only: [:index, :show]

    #cart_itemsコントローラ
   delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
   resources :cart_items, only: [:index, :create, :update, :destroy]

    #deriveriesコントローラ
   resources :deriveries, only: [:index, :create, :destroy, :edit, :update]

   get 'item_search', to: 'searches#item_search'
  end



 # 管理者用ルート
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }

  namespace :admin do
   root :to => 'homes#top'
   resources :customers, only: [:index, :edit, :update, :show]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:show, :index, :new, :create, :edit, :update]
   resources :orders, only: [:show, :update, :index]
   resources :order_details, only: [:update]
  end

end
