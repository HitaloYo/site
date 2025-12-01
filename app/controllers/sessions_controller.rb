class SessionsController < ApplicationController
  layout 'sessions'
  
  def new
    # Renderiza o formulário de login
  end

  def create
    aluno = Aluno.authenticate(params[:matricula], params[:password])
    
    if aluno
      session[:aluno_id] = aluno.id
      redirect_to root_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = 'Matrícula ou senha inválida'
      render :new
    end
  end

  def destroy
    session[:aluno_id] = nil
    redirect_to login_path, notice: 'Logout realizado com sucesso!'
  end
end