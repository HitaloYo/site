class Frequencia < ApplicationRecord
  belongs_to :matricula

  validates :data, presence: true
  validates :presente, inclusion: { in: [true, false] }
end