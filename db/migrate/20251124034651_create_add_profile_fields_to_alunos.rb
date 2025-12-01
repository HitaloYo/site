class CreateAddProfileFieldsToAlunos < ActiveRecord::Migration[8.0]
  def change
    # Dados pessoais adicionais
    add_column :alunos, :cor_raca, :string
    add_column :alunos, :estado_civil, :string
    add_column :alunos, :sexo, :string
    add_column :alunos, :estado_nascimento, :string
    add_column :alunos, :cidade_nascimento, :string
    
    # Identificação
    add_column :alunos, :tipo_documento, :string
    add_column :alunos, :numero_documento, :string
    add_column :alunos, :data_expedicao, :date
    add_column :alunos, :orgao_emissor, :string
    add_column :alunos, :uf_emissao, :string
    add_column :alunos, :nome_pai, :string
    add_column :alunos, :nome_mae, :string
    
    # Contato
    add_column :alunos, :ddd, :string
    add_column :alunos, :celular, :string
    
    # Endereço
    add_column :alunos, :cep, :string
    add_column :alunos, :logradouro, :string
    add_column :alunos, :numero, :string
    add_column :alunos, :bairro, :string
    add_column :alunos, :cidade, :string
    add_column :alunos, :estado, :string
    
    # Informações acadêmicas
    add_column :alunos, :periodo, :string
    add_column :alunos, :turno, :string
    add_column :alunos, :unidade, :string
  end
end