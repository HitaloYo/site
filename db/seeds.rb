# db/seeds.rb
puts "🌱 Iniciando seed otimizado..."

# 1. Limpeza do Banco (ordem reversa por dependências)
puts "🗑️  Limpando dados existentes..."
[Nota, Avaliacao, Frequencia, Matricula, Turma, Disciplina, Professor, Aluno].each do |model|
  model.destroy_all
  puts "   → #{model.name} limpo"
end

# 2. Criando Professores
puts "👨‍🏫 Criando 5 Professores..."
professores = [
  Professor.create!(
    matricula: "DOC2024001",
    nome: "Dr. Carlos Eduardo Sampaio",
    email: "carlos.sampaio@instituto.edu.br",
    departamento: "Ciência da Computação",
    ativo: true
  ),
  Professor.create!(
    matricula: "DOC2024002",
    nome: "Dra. Ana Beatriz Oliveira",
    email: "ana.oliveira@instituto.edu.br",
    departamento: "Matemática Aplicada",
    ativo: true
  ),
  Professor.create!(
    matricula: "DOC2024003",
    nome: "Prof. Roberto Mendes Silva",
    email: "roberto.silva@instituto.edu.br",
    departamento: "Engenharia de Software",
    ativo: true
  ),
  Professor.create!(
    matricula: "DOC2024004",
    nome: "Dra. Fernanda Costa Rodrigues",
    email: "fernanda.rodrigues@instituto.edu.br",
    departamento: "Banco de Dados",
    ativo: true
  ),
  Professor.create!(
    matricula: "DOC2024005",
    nome: "Prof. Marcos Vinícius Lima",
    email: "marcos.lima@instituto.edu.br",
    departamento: "Redes de Computadores",
    ativo: true
  )
]

# 3. Criando Disciplinas (8 disciplinas)
puts "📚 Criando 8 Disciplinas..."
disciplinas = [
  Disciplina.create!(codigo: "CC101", nome: "Algoritmos e Lógica", carga_horaria: 80, professor: professores[0]),
  Disciplina.create!(codigo: "CC102", nome: "Cálculo I", carga_horaria: 60, professor: professores[1]),
  Disciplina.create!(codigo: "CC103", nome: "Banco de Dados I", carga_horaria: 60, professor: professores[3]),
  Disciplina.create!(codigo: "CC104", nome: "Engenharia de Software", carga_horaria: 60, professor: professores[2]),
  Disciplina.create!(codigo: "CC105", nome: "Redes de Computadores", carga_horaria: 60, professor: professores[4]),
  Disciplina.create!(codigo: "CC106", nome: "Estruturas de Dados", carga_horaria: 60, professor: professores[0]),
  Disciplina.create!(codigo: "CC107", nome: "Sistemas Operacionais", carga_horaria: 60, professor: professores[2]),
  Disciplina.create!(codigo: "CC108", nome: "Inteligência Artificial", carga_horaria: 60, professor: professores[0])
]

# 4. Criando Turmas (2 turmas por disciplina)
puts "🏫 Criando 16 Turmas (2 por disciplina)..."
turmas = []
disciplinas.each do |disciplina|
  2.times do |i|
    turma = Turma.create!(
      disciplina: disciplina,
      codigo_turma: "#{disciplina.codigo}T#{i + 1}",
      semestre: 1,
      ano: 2024,
      vagas_totais: 40,
      vagas_ocupadas: 0
    )
    turmas << turma
    
    # Criar 3 avaliações por turma
    Avaliacao.create!(turma: turma, tipo: "Prova 1", descricao: "Primeira avaliação", peso: 3.0, data_avaliacao: Date.today - 2.months)
    Avaliacao.create!(turma: turma, tipo: "Prova 2", descricao: "Segunda avaliação", peso: 3.0, data_avaliacao: Date.today - 1.month)
    Avaliacao.create!(turma: turma, tipo: "Projeto", descricao: "Projeto final", peso: 4.0, data_avaliacao: Date.today)
  end
end

# 5. Criando 10 Alunos com Perfil Completo
puts "🎓 Criando 10 Alunos com perfil completo..."

10.times do |i|
  aluno = Aluno.create!(
    # Dados Básicos
    matricula: "2024#{1000 + i}",
    nome: "Aluno #{i + 1} da Silva",
    email: "aluno#{i + 1}@instituto.edu.br",
    password: "senha123",
    cpf: "#{10000000000 + i}",
    data_nascimento: Date.new(1995 + i, (i % 12) + 1, (i % 28) + 1),
    data_criacao: DateTime.now,
    ativo: true,
    curso: ["Ciência da Computação", "Engenharia", "Sistemas de Informação"][i % 3],
    
    # Perfil
    cor_raca: ["Branca", "Preta", "Parda"][i % 3],
    estado_civil: ["Solteiro(a)", "Casado(a)"][i % 2],
    sexo: i.even? ? "Masculino" : "Feminino",
    estado_nascimento: "SP",
    cidade_nascimento: "São Paulo",
    tipo_documento: "RG",
    numero_documento: "#{40000000 + i}",
    data_expedicao: Date.today - 5.years,
    orgao_emissor: "SSP",
    uf_emissao: "SP",
    nome_pai: "Pai do Aluno #{i}",
    nome_mae: "Mãe do Aluno #{i}",
    
    # Contato
    ddd: "11",
    celular: "1198888#{'%04d' % i}",
    
    # Endereço
    cep: "0100100#{i}",
    logradouro: "Rua Exemplo",
    numero: "#{100 + i}",
    bairro: "Centro",
    cidade: "São Paulo",
    estado: "SP",
    
    # Acadêmico
    periodo: "#{(i % 6) + 1}º",
    turno: ["Matutino", "Noturno"][i % 2],
    unidade: "Campus Central"
  )
  
  # 6. Matricular cada aluno em 4 turmas aleatórias
  puts "   📝 Matriculando #{aluno.nome}..."
  
  turmas.sample(4).each do |turma|
    # Criar matrícula
    matricula = Matricula.create!(
      aluno: aluno,
      turma: turma,
      situacao: "Cursando",
      frequencia: rand(70..100)
    )
    
    # 7. Lançar notas para cada avaliação da turma
    total_pontos = 0
    total_peso = 0
    
    turma.avaliacoes.each do |avaliacao|
      # Nota aleatória (entre 4 e 10)
      nota = rand(4.0..10.0).round(2)
      
      Nota.create!(
        matricula: matricula,
        avaliacao: avaliacao,
        valor: nota
      )
      
      # Calcular média ponderada
      total_pontos += nota * avaliacao.peso
      total_peso += avaliacao.peso
    end
    
    # Calcular média final
    if total_peso > 0
      media_final = (total_pontos / total_peso).round(2)
      situacao = media_final >= 6.0 ? "Aprovado" : "Reprovado"
      
      matricula.update!(
        nota_final: media_final,
        situacao: situacao
      )
    end
    
    # 8. Criar registros de frequência (15 dias)
    15.times do |dia|
      Frequencia.create!(
        matricula: matricula,
        data: Date.today - (15 - dia).days,
        presente: rand(100) < 85 # 85% de presença
      )
    end
    
    # Atualizar vagas ocupadas
    turma.update!(vagas_ocupadas: turma.vagas_ocupadas + 1)
  end
end

# 9. Criar Aluno Admin
puts "👑 Criando Aluno Admin..."
Aluno.create!(
  matricula: "20240000",
  nome: "Administrador",
  email: "admin@instituto.edu.br",
  password: "admin123",
  cpf: "00000000000",
  data_nascimento: Date.new(1990, 1, 1),
  data_criacao: DateTime.now,
  ativo: true,
  curso: "Ciência da Computação",
  periodo: "6º",
  turno: "Noturno",
  unidade: "Campus Central",
  cor_raca: "Branca",
  estado_civil: "Solteiro(a)",
  sexo: "Masculino",
  estado_nascimento: "SP",
  cidade_nascimento: "São Paulo",
  tipo_documento: "RG",
  numero_documento: "00000000",
  data_expedicao: Date.today - 10.years,
  orgao_emissor: "SSP",
  uf_emissao: "SP",
  nome_pai: "Admin Pai",
  nome_mae: "Admin Mãe",
  ddd: "11",
  celular: "11999990000",
  cep: "00000000",
  logradouro: "Rua Admin",
  numero: "1",
  bairro: "Centro",
  cidade: "São Paulo",
  estado: "SP"
)

puts ""
puts "✅ SEED CONCLUÍDO!"
puts "=================="
puts "📊 ESTATÍSTICAS:"
puts "   👨‍🎓 Alunos: #{Aluno.count}"
puts "   👨‍🏫 Professores: #{Professor.count}"
puts "   📚 Disciplinas: #{Disciplina.count}"
puts "   🏫 Turmas: #{Turma.count}"
puts "   📝 Matrículas: #{Matricula.count}"
puts "   📊 Avaliações: #{Avaliacao.count}"
puts "   🔢 Notas: #{Nota.count}"
puts "   📅 Frequências: #{Frequencia.count}"
puts ""
puts "🔑 LOGINS PARA TESTE:"
puts "   👑 Admin: matrícula '20240000' / senha 'admin123'"
puts "   👨‍🎓 Aluno 1: matrícula '20241000' / senha 'senha123'"
puts "   👨‍🎓 Aluno 2: matrícula '20241001' / senha 'senha123'"