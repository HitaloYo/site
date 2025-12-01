class FinanceiroController < ApplicationController
  layout 'financeiro'
  before_action :require_login
  def index
    @aluno = current_aluno
  end

  def solicitar_boleto
    # Lógica para processar a solicitação do boleto
    # ...
    redirect_to financeiro_path, notice: 'Solicitação enviada com sucesso!'
  end
end
