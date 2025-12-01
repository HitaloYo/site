class CreatePaaSchema < ActiveRecord::Migration[7.0]
  def change
    # 1. Tabelas Independentes (Não dependem de ninguém)
    
    create_table :professors do |t|
      t.string :matricula, null: false
      t.string :nome, null: false
      t.string :email, null: false
      t.string :departamento, null: false
      t.boolean :ativo, default: true, null: false
      t.timestamps
    end

    create_table :alunos do |t|
      t.string :matricula, null: false
      t.string :nome, null: false
      t.string :email, null: false
      t.string :senha, null: false
      t.string :cpf, null: false
      t.datetime :data_nascimento, null: false
      t.datetime :data_criacao, null: false
      t.boolean :ativo, null: false, default: true
      t.timestamps
    end

    create_table :calendarios do |t|
      t.string :titulo, null: false
      t.text :descricao, null: false
      t.datetime :data_inicio, null: false
      t.datetime :data_fim, null: false
      t.string :tipo, null: false
      t.boolean :recorrente, null: false, default: false
      t.timestamps
    end

    # 2. Tabelas de Estrutura Acadêmica (Dependência em Cascata)

    create_table :disciplinas do |t|
      t.references :professor, null: false, foreign_key: true
      t.string :codigo, null: false
      t.string :nome, null: false
      t.integer :carga_horaria, null: false
      t.timestamps
    end

    create_table :turmas do |t|
      t.references :disciplina, null: false, foreign_key: true
      t.string :codigo_turma, null: false
      t.integer :semestre, null: false
      t.integer :ano, null: false
      t.integer :vagas_totais, null: false
      t.integer :vagas_ocupadas, default: 0, null: false
      t.timestamps
    end

    create_table :matriculas do |t|
      t.references :aluno, null: false, foreign_key: true
      t.references :turma, null: false, foreign_key: true
      t.string :situacao, null: false
      t.float :nota_final
      t.integer :frequencia, default: 0
      t.timestamps
    end

    # 3. Tabelas Dependentes de Turmas e Matrículas

    create_table :avaliacoes do |t|
      t.references :turma, null: false, foreign_key: true
      t.string :tipo, null: false
      t.string :descricao, null: false
      t.float :peso, null: false
      t.datetime :data_avaliacao, null: false
      t.timestamps
    end

    create_table :notas do |t|
      t.references :matricula, null: false, foreign_key: true
      # AQUI ESTAVA O ERRO: Adicionamos { to_table: :avaliacoes } para corrigir o plural
      t.references :avaliacao, null: false, foreign_key: { to_table: :avaliacoes }
      t.float :valor
      t.timestamps
    end

    create_table :frequencias do |t|
      t.references :matricula, null: false, foreign_key: true
      t.date :data, null: false
      t.boolean :presente, null: false
      t.timestamps
    end

    # 4. Outras Tabelas Dependentes

    create_table :financeiros do |t|
      t.references :aluno, null: false, foreign_key: true
      t.string :descricao, null: false
      t.decimal :valor, precision: 8, scale: 2, null: false
      t.date :data_vencimento, null: false
      t.date :data_pagamento
      t.string :status, null: false
      t.string :tipo, null: false
      t.timestamps
    end

    create_table :solicitacoes do |t|
      t.references :aluno, null: false, foreign_key: true
      t.string :tipo, null: false
      t.text :descricao, null: false
      t.string :status, null: false
      t.datetime :data_criacao, null: false
      t.datetime :data_atualizacao, null: false
      t.timestamps
    end

    create_table :avisos do |t|
      t.references :autor, polymorphic: true, null: false
      t.string :titulo, null: false
      t.text :conteudo, null: false
      t.datetime :data_publicacao, null: false
      t.datetime :data_expiracao
      t.boolean :importante, null: false, default: false
      t.timestamps
    end

    create_table :destinatario_avisos do |t|
      t.references :aviso, null: false, foreign_key: true
      t.references :aluno, null: false, foreign_key: true
      t.boolean :lido, null: false, default: false
      t.timestamps
    end

    # 5. Índices Únicos (Performance e Integridade)
    add_index :alunos, :matricula, unique: true
    add_index :alunos, :email, unique: true
    add_index :alunos, :cpf, unique: true
    
    add_index :professors, :matricula, unique: true
    add_index :professors, :email, unique: true
    
    add_index :disciplinas, :codigo, unique: true
    add_index :turmas, :codigo_turma, unique: true
    
    # Índices compostos para garantir unicidade lógica
    add_index :matriculas, [:aluno_id, :turma_id], unique: true
    add_index :frequencias, [:matricula_id, :data], unique: true
  end
end