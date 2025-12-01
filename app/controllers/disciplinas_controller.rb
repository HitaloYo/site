class DisciplinasController < ApplicationController
  layout 'disciplinas'
  before_action :require_login
  
  def index
    # Carrega as disciplinas do aluno logado através das matrículas
    @disciplinas = current_aluno.turmas.joins(:disciplina).distinct
  end

end
