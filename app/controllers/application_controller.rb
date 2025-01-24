class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Personalize o redirecionamento após o logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redireciona para a página de login
  end
end
