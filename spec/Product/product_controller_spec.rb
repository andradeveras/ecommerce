require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include Devise::Test::ControllerHelpers # Inclui suporte ao Devise para testes de controladores

  before do
    @user = User.create(email: "test@example.com", password: "SenhaForte@123") # Criação manual de um usuário e autenticação
    sign_in @user
  end

  describe "GET /products" do
    it "returns a successful response" do #Verifica se a rota de produtos (GET /products) retorna um status 200
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /products/:id" do # Verifica se a rota de detalhes de produto (GET /products/:id) retorna um status 200
    it "returns the details of a product" do
      # Criação manual de um produto
      product = Product.create(name: "Sample Product", description: "Sample Description", price: 100.0)

      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success) 
    end
  end
end
