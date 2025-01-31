require 'rails_helper'

# Este teste verifica se o usuário tem um carrinho associado a ele ao criar uma conta de usuário no sistema.
RSpec.describe User, type: :model do
  context "associations" do
    it "has one cart" do
      user = User.create(email: "1@1.com", password: "SenhaForte@123", password_confirmation: "SenhaForte@123")
      cart = Cart.create(user: user)

      expect(user.cart.id).to eq(cart.id) # Verifica se o carrinho do usuário é o mesmo que o carrinho criado. 
      expect(user.cart.user_id).to eq(user.id) # Verifica se o usuário do carrinho é o mesmo que o usuário criado.
    end    
  end

  describe "validações de senha" do
    it "é válido com uma senha forte" do
      user = User.new(email: "1@1.com", password: "SenhaForte@123", password_confirmation: "SenhaForte@123")
      expect(user).to be_valid
    end

    it "é inválido com uma senha curta" do
      user = User.new(email: "1@1.com", password: "Curta1@", password_confirmation: "Curta1@")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("is too short (minimum is 12 characters)")
    end

    it "é inválido sem caractere especial" do
      user = User.new(email: "1@1.com", password: "SenhaForte123", password_confirmation: "SenhaForte123")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("deve conter pelo menos uma letra maiúscula, um número e um caractere especial")
    end

    it "é inválido sem número" do
      user = User.new(password: "SenhaForte@", password_confirmation: "SenhaForte@")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("deve conter pelo menos uma letra maiúscula, um número e um caractere especial")
    end

    it "é inválido sem letra maiúscula" do
      user = User.new(password: "senhafraca@123", password_confirmation: "senhafraca@123")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("deve conter pelo menos uma letra maiúscula, um número e um caractere especial")
    end
  end
end

