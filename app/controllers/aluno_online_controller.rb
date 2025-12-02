class AlunoOnlineController < ApplicationController
  layout 'aluno_online'
  before_action :require_login
  def index
    @aluno = current_aluno
    @matriculas = @aluno.matriculas
                       .includes(turma: { disciplina: :professor })
                       .includes(:notas)
                       .order(created_at: :desc)
    
    # Calcular IRA (Índice de Rendimento Acadêmico)
    @ira = calcular_ira(@aluno)
    
    # Calcular créditos (usando a situação real do seed)
    @creditos_concluidos = calcular_creditos_concluidos(@aluno)
  end
  
  private
  
  def calcular_ira(aluno)
    # Exemplo simplificado - você pode implementar a lógica real aqui
    matriculas_aprovadas = aluno.matriculas.where(situacao: 'Aprovado')
    return 0.0 if matriculas_aprovadas.empty?
    
    soma_notas = matriculas_aprovadas.sum(:nota_final).to_f
    (soma_notas / matriculas_aprovadas.count).round(1)
  end
  
  def calcular_creditos_concluidos(aluno)
    # Exemplo simplificado - 4 créditos por disciplina aprovada
    matriculas_aprovadas = aluno.matriculas.where(situacao: 'Aprovado')
    creditos_concluidos = matriculas_aprovadas.count * 4
    creditos_totais = 32 # Exemplo: 8 disciplinas * 4 créditos
    
    "#{creditos_concluidos}/#{creditos_totais}"
  end
end
