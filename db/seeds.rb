# db/seeds.rb

puts "🌱 Iniciando o seed..."

# 1. Limpeza do Banco de Dados (Ordem inversa para respeitar Foreign Keys)
puts "🗑️  Limpando dados existentes (Notas, Matrículas, Turmas, Professores, Alunos)..."
Nota.destroy_all
Avaliacao.destroy_all
Frequencia.destroy_all
Matricula.destroy_all
Turma.destroy_all
Disciplina.destroy_all
Aluno.destroy_all
Professor.destroy_all

# Configuração básica
PASSWORD_DEFAULT = "senha123"
DATA_NASCIMENTO_PADRAO = 25.years.ago.to_date
DATA_CRIACAO_PADRAO = Time.now

# 2. Criando Professores
puts "👨‍🏫 Criando Professores (3)..."
professores = {}
professores[:exatas] = Professor.create!(
  matricula: "DOC1001", nome: "Dr. Marcos Álvares", email: "marcos@teste.com",
  departamento: "Ciências Exatas"
)
professores[:humanas] = Professor.create!(
  matricula: "DOC1002", nome: "Dra. Eliana Costa", email: "eliana@teste.com",
  departamento: "Ciências Humanas"
)
professores[:saude] = Professor.create!(
  matricula: "DOC1003", nome: "Dr. Gustavo Lima", email: "gustavo@teste.com",
  departamento: "Saúde e Biológicas"
)
professores[:direito] = Professor.create!(
  matricula: "DOC1004", nome: "Dra. Renata Fontes", email: "renata@teste.com",
  departamento: "Ciências Jurídicas"
)

# 3. Criando Disciplinas e Turmas
puts "📚 Criando Disciplinas, Turmas e Avaliações..."

# --- Cursos ---
CURSOS = [
  "Ciências da Computação",
  "Enfermagem",
  "Direito",
  "Engenharia Civil",
  "Pedagogia"
]
turmas_por_curso = {}

# --- CC ---
disc_cc_1 = Disciplina.create!(professor: professores[:exatas], codigo: "ALG101", nome: "Algoritmos e Estrutura de Dados", carga_horaria: 60)
turma_cc_1 = Turma.create!(disciplina: disc_cc_1, codigo_turma: "CC101-T01", semestre: 1, ano: 2024, vagas_totais: 30)
turmas_por_curso["Ciências da Computação"] = [turma_cc_1]

# --- Enfermagem ---
disc_enf_1 = Disciplina.create!(professor: professores[:saude], codigo: "ANAT101", nome: "Anatomia Humana", carga_horaria: 80)
turma_enf_1 = Turma.create!(disciplina: disc_enf_1, codigo_turma: "ENF101-T02", semestre: 1, ano: 2024, vagas_totais: 25)
turmas_por_curso["Enfermagem"] = [turma_enf_1]

# --- Direito ---
disc_dir_1 = Disciplina.create!(professor: professores[:direito], codigo: "CONST101", nome: "Direito Constitucional", carga_horaria: 60)
turma_dir_1 = Turma.create!(disciplina: disc_dir_1, codigo_turma: "DIR101-T03", semestre: 1, ano: 2024, vagas_totais: 40)
turmas_por_curso["Direito"] = [turma_dir_1]

# --- Engenharia Civil ---
disc_eng_1 = Disciplina.create!(professor: professores[:exatas], codigo: "CALC101", nome: "Cálculo Diferencial I", carga_horaria: 80)
turma_eng_1 = Turma.create!(disciplina: disc_eng_1, codigo_turma: "ENG101-T04", semestre: 1, ano: 2024, vagas_totais: 35)
turmas_por_curso["Engenharia Civil"] = [turma_eng_1]

# --- Pedagogia ---
disc_ped_1 = Disciplina.create!(professor: professores[:humanas], codigo: "PED101", nome: "Psicologia da Educação", carga_horaria: 40)
turma_ped_1 = Turma.create!(disciplina: disc_ped_1, codigo_turma: "PED101-T05", semestre: 1, ano: 2024, vagas_totais: 50)
turmas_por_curso["Pedagogia"] = [turma_ped_1]

# --- Avaliações Padrão (para todas as Turmas) ---
turmas_por_curso.values.flatten.each do |turma|
  Avaliacao.create!(turma: turma, tipo: "Prova 1", descricao: "Primeira Prova", peso: 40.0, data_avaliacao: 2.weeks.from_now)
  Avaliacao.create!(turma: turma, tipo: "Trabalho", descricao: "Trabalho Final", peso: 20.0, data_avaliacao: 4.weeks.from_now)
  Avaliacao.create!(turma: turma, tipo: "Prova Final", descricao: "Avaliação Final", peso: 40.0, data_avaliacao: 6.weeks.from_now)
end


# 4. Criando 10 Alunos Separadamente
puts "🎓 Criando 10 Alunos..."
aluno_data = [
  { nome: "Hitalo Yo (CC)", curso: "Ciências da Computação" },
  { nome: "Mariana Silva (CC)", curso: "Ciências da Computação" },
  { nome: "Juliana Santos (Enf)", curso: "Enfermagem" },
  { nome: "Pedro Rocha (Enf)", curso: "Enfermagem" },
  { nome: "Lívia Almeida (Dir)", curso: "Direito" },
  { nome: "Felipe Costa (Dir)", curso: "Direito" },
  { nome: "Gabriel Neves (Eng)", curso: "Engenharia Civil" },
  { nome: "Isabela Gomes (Eng)", curso: "Engenharia Civil" },
  { nome: "Tatiane Souza (Ped)", curso: "Pedagogia" },
  { nome: "Ricardo Pires (Ped)", curso: "Pedagogia" },
]

alunos = []
aluno_data.each_with_index do |data, i|
  matricula_num = 20240001 + i
  email_prefix = data[:nome].split.first.downcase.gsub(/[^a-z]/, '')
  curso_abbr = data[:curso].split.map{|w| w[0]}.join.downcase

  aluno = Aluno.create!(
    matricula: matricula_num.to_s,
    nome: data[:nome],
    email: "#{email_prefix}.#{matricula_num}@#{curso_abbr}.edu.br",
    password: PASSWORD_DEFAULT,
    cpf: "00#{i}#{i}0000#{i}", # CPF único simples
    data_nascimento: DATA_NASCIMENTO_PADRAO,
    data_criacao: DATA_CRIACAO_PADRAO,
    ativo: true,
    curso: data[:curso] # Novo campo 'curso'
  )
  alunos << aluno
end

# 5. Matricular Alunos, Lançar Notas e Calcular Média
puts "📝 Matricular Alunos e Lançar Notas..."

alunos.each do |aluno|
  turmas_do_curso = turmas_por_curso[aluno.curso] || []

  turmas_do_curso.each do |turma|
    # Cria Matrícula
    matricula = Matricula.create!(
      aluno: aluno,
      turma: turma,
      situacao: "Cursando",
      # Frequência (usado na sua migração)
      frequencia: rand(70..100)
    )

    media_ponderada = 0.0
    peso_total = 0.0

    # Lança notas para cada avaliação da turma
    turma.avaliacoes.each do |avaliacao|
      # Gera uma nota aleatória (maior chance de aprovação)
      nota_tirada = (rand(40..100) / 10.0)
      
      Nota.create!(
        matricula: matricula,
        avaliacao: avaliacao,
        valor: nota_tirada
      )

      media_ponderada += (nota_tirada * avaliacao.peso)
      peso_total += avaliacao.peso
    end

    # Define situação final
    media_final = peso_total > 0.0 ? (media_ponderada / peso_total) : 0.0
    situacao_final = media_final >= 6.0 ? "Aprovado" : "Reprovado"
    
    # Atualiza a situação final da matrícula
    matricula.update!(situacao: situacao_final)
    
    puts " - ✅ #{aluno.nome} matriculado em #{turma.disciplina.nome}. Situação: #{situacao_final} (Média: #{'%.2f' % media_final})"
  end
end

puts "---------------------------------------------------------"
puts "✅ Seed finalizado! 10 alunos criados e matriculados."
puts "Login de Teste (CC): Matrícula 20240001 / Senha: #{PASSWORD_DEFAULT}"
puts "---------------------------------------------------------"