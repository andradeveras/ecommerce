require 'rails_helper'

# Este teste verifica se o usuário tem um carrinho associado a ele ao criar uma conta de usuário no sistema.
RSpec.describe User, type: :model do
  context "associations" do
    it "has one cart" do
      user = User.create(email: "1@1.com", password: "123456", password_confirmation: "123456")
      cart = Cart.create(user_id: user.id)
      expect(user.cart).to eq(cart)
    end    
  end
end

