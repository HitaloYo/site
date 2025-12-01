class Turma < ApplicationRecord
  belongs_to :disciplina
  has_many :matriculas
  has_many :alunos, through: :matriculas
  has_many :avaliacoes
  
  validates :codigo_turma, presence: true, uniqueness: true
  validates :semestre, presence: true
  validates :ano, presence: true
  validates :vagas_totais, presence: true
end