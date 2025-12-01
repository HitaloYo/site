class Nota < ApplicationRecord
  belongs_to :matricula
  belongs_to :avaliacao

  validates :valor, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end