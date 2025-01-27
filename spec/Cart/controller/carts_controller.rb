require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) do
    User.create(email: "test@example.com", password: "password", password_confirmation: "password")
  end
  let(:cart) do
    Cart.create(user: user)
  end

  before do
    sign_in user # Agora o Devise deve permitir o uso de sign_in
  end

  describe "GET #show" do
    it "assigns the correct cart to @cart" do
      get :show

      expect(response.status).to eq(200)
      expect(response.body).to include(user.cart.id.to_s)    
    end
  end

  describe "POST #add_item" do
    it "adds an item to the cart" do
      product = Product.create(name: "Produto", price: 10.0)
      post :add_item, params: { product_id: product.id }
      
      expect(user.cart.cart_items.count).to eq(1)
      expect(user.cart.cart_items.first.product).to eq(product)
    end
  end

  describe "DELETE #remove_item" do
    it "removes an item from the cart" do
      product = Product.create(name: "Produto", price: 10.0)
      cart_item = user.cart.cart_items.create!(product: product, quantity: 1)

      delete :remove_item, params: { id: cart_item.id }

      expect(user.cart.cart_items.count).to eq(0)
    end
  end

  describe "PATCH #update_item" do
    it "updates the quantity of an item in the cart" do
      product = Product.create(name: "Produto", price: 10.0)
      cart_item = user.cart.cart_items.create!(product: product, quantity: 1)

      patch :update_item, params: { id: cart_item.id, quantity: 3 }

      cart_item.reload
      expect(cart_item.quantity).to eq(3)
    end
  end
end
