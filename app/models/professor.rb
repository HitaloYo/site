class Professor < ApplicationRecord
  validates :matricula, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :departamento, presence: true
  
  has_many :disciplinas
end