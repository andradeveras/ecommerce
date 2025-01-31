require 'rails_helper'

RSpec.describe "User Authentication", type: :request do
  let(:valid_user) do
    User.create(email: "test@example.com", password: "SenhaForte@123", password_confirmation: "SenhaForte@123")
  end

  describe "POST /users/sign_up" do
    it "registers a new user successfully" do
      post user_registration_path, params: {
        user: {
          email: "newuser@example.com",
          password: "SenhaForte@123",
          password_confirmation: "SenhaForte@123"
        }
      }
      expect(response).to have_http_status(:see_other)  
      follow_redirect!
    end
    describe "DELETE /users/sign_out" do
      it "logs out successfully" do
        # Cria o usuário válido
        valid_user 
        post user_session_path, params: {
          user: {
            email: valid_user.email,
            password: valid_user.password
          }
        }
        expect(response).to have_http_status(:see_other) # Verifica se o status é 303 ou 302, dependendo da configuração
        follow_redirect!
  
        #Faz o logout
        delete destroy_user_session_path, headers: { "Accept" => "application/json" }
  
        # Verifica se o logout foi bem sucedido
        expect(response).to have_http_status(:see_other)
        follow_redirect!
        expect(response.body).to include("Signed out successfully")
      end
    end
  end

  describe "POST /users/sign_in" do
    it "logs in successfully with valid credentials" do
      valid_user
      post user_session_path, params: {
        user: {
          email: "test@example.com",
          password: "SenhaForte@123"
        }
      }
      expect(response).to have_http_status(:see_other)  
      follow_redirect!
      expect(response.body).to include("Signed in successfully")
    end
  end
end
