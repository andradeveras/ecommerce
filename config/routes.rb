Rails.application.routes.draw do
  devise_for :users

  root 'products#index'

  resources :products, only: [:index, :show]
  
  resources :carts, only: [:show] do
    member do
      post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
      delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
      put 'update_item/:id', to: 'carts#update_item', as: 'update_item'
    end
  end
end
