class AddPasswordDigestToAlunos < ActiveRecord::Migration[7.0]
  def change
    # Remove a coluna antiga 'senha' (texto puro) e adiciona a criptografada
    remove_column :alunos, :senha, :string
    add_column :alunos, :password_digest, :string, null: false
  end
end