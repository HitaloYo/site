ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'aluno', 'alunos'
  inflect.irregular 'nota', 'notas'
  inflect.irregular 'frequencia', 'frequencias'
  inflect.irregular 'avaliacao', 'avaliacoes' # Isso resolve o plural da tabela também!
  inflect.irregular 'professor', 'professors' # Ou 'professores' se você mudou a tabela
  inflect.irregular 'turma', 'turmas'
end