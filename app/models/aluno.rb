# app/models/aluno.rb
class Aluno < ApplicationRecord
  has_secure_password
  
  validates :matricula, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :data_nascimento, presence: true
  validates :data_criacao, presence: true

  has_many :matriculas
  has_many :turmas, through: :matriculas
  has_many :disciplinas, through: :turmas
  
  # Opções para tipo de documento
  TIPOS_DOCUMENTO = ['RG', 'CNH', 'Passaporte', 'RNE', 'CTPS', 'Outro']
  
  validates :celular, format: { with: /\A\d{10,11}\z/, message: "deve ter 10 ou 11 dígitos" }, allow_blank: true
  validates :cep, format: { with: /\A\d{8}\z/, message: "deve ter 8 dígitos" }, allow_blank: true
  
  def self.authenticate(matricula, password)
    aluno = find_by(matricula: matricula, ativo: true)
    aluno&.authenticate(password)
  end
  
  def iniciais
    nome.split.map { |n| n[0] }.join.upcase
  end
end