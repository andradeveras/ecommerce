Rails.application.routes.draw do

  root 'products#index'
  
  devise_for :users

  resources :users, only: [:show]

  resources :products, only: [:index, :show]
  
  resource :cart, only: [:show] do
    member do
      post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
      delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
      put 'update_item/:id', to: 'carts#update_item', as: 'update_item'
    end
  end
end
