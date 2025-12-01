# app/models/matricula.rb
class Matricula < ApplicationRecord
  belongs_to :aluno
  belongs_to :turma
  has_many :notas
  has_many :frequencias
  
  validates :situacao, presence: true
  validates :aluno_id, uniqueness: { scope: :turma_id }
end