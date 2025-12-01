class AddCursoToAlunos < ActiveRecord::Migration[7.1] # ou sua versão
  def change
    add_column :alunos, :curso, :string, default: "Não informado", null: false
  end
end