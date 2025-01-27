require 'rails_helper'

# Este teste verifica se o usuário tem um carrinho associado a ele ao criar uma conta de usuário no sistema.
RSpec.describe User, type: :model do
  context "associations" do
    it "has one cart" do
      user = User.create(email: "1@1.com", password: "123456", password_confirmation: "123456")
      cart = Cart.create(user: user)

      expect(user.cart.id).to eq(cart.id) # Verifica se o carrinho do usuário é o mesmo que o carrinho criado. 
      expect(user.cart.user_id).to eq(user.id) # Verifica se o usuário do carrinho é o mesmo que o usuário criado.

    end    
  end
end

