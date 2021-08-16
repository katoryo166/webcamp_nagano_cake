Rails.application.routes.draw do

  get 'cart_items/index'
  devise_for :customers, :controllers => {
    :sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
    :passwords => 'customers/passwords'
   }
  devise_for :admins, :controllers => {
    :sessions => 'admin/admins/sessions',
    :registrations => 'admin/admins/registrations',
    :passwords => 'admin/admins/passwords'
   }

   namespace :admin do
    resources :items,only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :genres,only: [:index,:create,:edit,:update, :show, :destroy]
    resources :customers,only: [:index,:show, :create,:edit, :update, :destroy]
  end

    resources :items, only: [:index, :show]
    resources :customers, only:[:show, :edit, :update]
    resource :customers,only: [:show] do
  		collection do
  	     get 'unsubscribe/:id' => 'customers#unsubscribe',  as:'confirm_unsubscribe'
  	     patch 'withdraw/:id' => 'customers#withdraw', as: 'withdraw'
  	  end
  	end
    resources :cart_items,only: [:index,:update,:create,:destroy]
    resources :orders, only:[:index, :new, :show, :thanks, :confirum]
     resources :address, only:[:index, :create, :edit, :update, :destroy]
    root 'homes#top'
    get 'homes/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
