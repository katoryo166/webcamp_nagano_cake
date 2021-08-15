Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/show'
    get 'items/edit'
  end
  get 'customers/show'
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
    resource :customers,only: [:edit] do
  		collection do
  	     get 'unsubscribe'
  	     patch 'withdraw'
  	  end
  	end
    resources :cart_items, only:[:index, :create, :update, :destroy]
    resources :orders, only:[:index, :new, :show, :thanks, :confirum]
     resources :address, only:[:index, :create, :edit, :update, :destroy]
    root 'homes#top'
    get 'homes/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
