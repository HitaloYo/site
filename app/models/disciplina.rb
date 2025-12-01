class Disciplina < ApplicationRecord
  belongs_to :professor
  has_many :turmas
  has_many :matriculas, through: :turmas
  
  validates :codigo, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :carga_horaria, presence: true
end