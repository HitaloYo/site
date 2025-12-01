class PerfilController < ApplicationController
  before_action :require_login
  
  def edit
    @aluno = current_aluno
  end
  
  def update
    @aluno = current_aluno
    
    if @aluno.update(aluno_params)
      redirect_to perfil_path, notice: 'Perfil atualizado com sucesso!'
    else
      render :edit
    end
  end
  
  def update_password
    @aluno = current_aluno
    
    if @aluno.authenticate(params[:current_password])
      if @aluno.update(password: params[:new_password], password_confirmation: params[:password_confirmation])
        redirect_to perfil_path, notice: 'Senha atualizada com sucesso!'
      else
        flash[:alert] = @aluno.errors.full_messages.join(', ')
        render :edit
      end
    else
      flash[:alert] = 'Senha atual incorreta'
      render :edit
    end
  end
  
  private
  
  def aluno_params
    params.require(:aluno).permit(
      :cor_raca, :estado_civil, :sexo, :estado_nascimento, :cidade_nascimento,
      :tipo_documento, :numero_documento, :data_expedicao, :orgao_emissor, 
      :uf_emissao, :nome_pai, :nome_mae, :ddd, :celular, :cep, :logradouro, 
      :numero, :bairro, :cidade, :estado, :curso, :periodo, :turno, :unidade
    )
  end
end