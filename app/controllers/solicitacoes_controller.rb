class SolicitacoesController < ApplicationController
  layout 'solicitacoes'
  before_action :require_login
  def index
  end
end
