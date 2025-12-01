class ApplicationController < ActionController::Base
  private
  
  def current_aluno
    @current_aluno ||= Aluno.find_by(id: session[:aluno_id]) if session[:aluno_id]
  end
  
  helper_method :current_aluno
  
  def require_login
    unless current_aluno
      redirect_to login_path, alert: "Você precisa fazer login para acessar esta página"
    end
  end
end