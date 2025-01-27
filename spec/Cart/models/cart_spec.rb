require 'rails_helper'

RSpec.describe Cart, type: :model do
  before do
    # Criação manual de um usuário
    @user = User.create(email: "test@example.com", password: "password")
    # Garantir que o usuário tenha um carrinho
    @user.create_cart_if_not_exists
    @cart = @user.cart
  end

  it "belongs to a user" do
    expect(@cart.user).to eq(@user)
  end

  it "has many cart_items" do
    # Criando itens no carrinho
    cart_item1 = @cart.cart_items.create(product_id: 1, quantity: 2)
    cart_item2 = @cart.cart_items.create(product_id: 2, quantity: 3)
    
    expect(@cart.cart_items).to include(cart_item1, cart_item2)
  end

  it "creates and destroys a cart item" do
    # Criação do usuário sem o callback
    @user = User.create!(email: "test2@example.com", password: "password")
  
    # Criação do produto
    product = Product.create!(name: "Produto Exemplo", price: 10.0)
  
    # Criação do cart manualmente, sem depender do callback
    @cart = @user.create_cart
    
    # Criação do cart_item
    cart_item = @cart.cart_items.create!(product: product, quantity: 2)
    expect(CartItem.count).to eq(1)
  
    # Destruição do cart_item
    cart_item.destroy
    expect(CartItem.count).to eq(0)
  end
end
