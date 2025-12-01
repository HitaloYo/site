class Avaliacao < ApplicationRecord
  self.table_name = "avaliacoes" 

  belongs_to :turma
  has_many :notas, dependent: :destroy

  validates :tipo, presence: true
  validates :descricao, presence: true
  validates :peso, presence: true, numericality: { greater_than: 0 }
  validates :data_avaliacao, presence: true
end