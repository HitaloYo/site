# db/seeds.rb

puts "🌱 Iniciando o seed..."

# 1. Limpeza do Banco de Dados (Ordem inversa para respeitar Foreign Keys)
puts "🗑️  Limpando dados existentes..."
Nota.destroy_all
Avaliacao.destroy_all
Frequencia.destroy_all
Matricula.destroy_all
Turma.destroy_all
Disciplina.destroy_all
Aluno.destroy_all
Professor.destroy_all

# 2. Criando Professores
puts "👨‍🏫 Criando Professores..."
professores = []
departamentos = ["Ciências Exatas", "Ciências Humanas", "Tecnologia"]

3.times do |i|
  professores << Professor.create!(
    matricula: "DOC#{202400 + i}",
    nome: ["Carlos Sampaio", "Ana Beatriz", "Roberto Mendes"][i],
    email: "docente#{i}@faculdade.edu.br",
    departamento: departamentos[i],
    ativo: true
  )
end

# 3. Criando Disciplinas e Turmas
puts "📚 Criando Disciplinas, Turmas e Avaliações..."
disciplinas_data = [
  { nome: "Algoritmos e Lógica", codigo: "ALG101", carga: 60, prof: professores[2] },
  { nome: "Cálculo Diferencial", codigo: "CAL101", carga: 80, prof: professores[0] },
  { nome: "Sociologia", codigo: "SOC101", carga: 40, prof: professores[1] },
  { nome: "Banco de Dados", codigo: "BD101", carga: 60, prof: professores[2] }
]

turmas = []

disciplinas_data.each_with_index do |d, index|
  disc = Disciplina.create!(
    nome: d[:nome],
    codigo: d[:codigo],
    carga_horaria: d[:carga],
    professor: d[:prof]
  )

  # Cria uma turma para a disciplina
  turma = Turma.create!(
    disciplina: disc,
    codigo_turma: "T#{100 + index}",
    semestre: 1,
    ano: 2024,
    vagas_totais: 40,
    vagas_ocupadas: 0
  )
  turmas << turma

  # Cria avaliações para a turma (Total peso 10)
  Avaliacao.create!(turma: turma, tipo: "Prova 1", descricao: "Conteúdo inicial", peso: 3.0, data_avaliacao: Date.today - 3.months)
  Avaliacao.create!(turma: turma, tipo: "Prova 2", descricao: "Conteúdo intermediário", peso: 3.0, data_avaliacao: Date.today - 2.months)
  Avaliacao.create!(turma: turma, tipo: "Projeto Final", descricao: "Aplicação prática", peso: 4.0, data_avaliacao: Date.today - 1.month)
end

# ... (código anterior dos professores e turmas continua igual) ...

# 4. Criando Alunos com Perfil Completo
puts "🎓 Criando 10 Alunos e lançando notas..."

10.times do |i|
  aluno = Aluno.create!(
    # Dados Básicos
    matricula: "2024#{1000 + i}",
    nome: "Estudante #{i + 1} da Silva",
    email: "aluno#{i + 1}@email.com",
    password: "senha123",
    cpf: "123456789#{i.to_s.rjust(2, '0')}", # SEM PONTOS OU TRAÇOS
    data_nascimento: Date.new(1995 + i, 5, 20),
    data_criacao: DateTime.now,
    ativo: true,

    # Perfil
    cor_raca: ["Branca", "Parda", "Preta", "Amarela"].sample,
    estado_civil: ["Solteiro(a)", "Casado(a)"].sample,
    sexo: ["Masculino", "Feminino"].sample,
    estado_nascimento: "SP",
    cidade_nascimento: "São Paulo",
    tipo_documento: "RG",
    numero_documento: "4455566#{i}X", # SEM PONTOS
    data_expedicao: Date.today - 5.years,
    orgao_emissor: "SSP",
    uf_emissao: "SP",
    nome_pai: "Pai do Aluno #{i}",
    nome_mae: "Mãe do Aluno #{i}",
    
    # Contato e Endereço
    ddd: "11",
    # CORREÇÃO AQUI: 11 dígitos e apenas números (ex: 11988880001)
    celular: "1198888#{i.to_s.rjust(4, '0')}", 
    
    # CORREÇÃO AQUI: 8 dígitos e apenas números
    cep: "01001000", 
    
    logradouro: "Av. Paulista",
    numero: "#{100 + i}",
    bairro: "Bela Vista",
    cidade: "São Paulo",
    estado: "SP",
    periodo: ["Matutino", "Noturno"].sample,
    turno: "Presencial",
    unidade: "Campus Central"
  )

  # ... (o restante do código das matrículas continua igual) ...
  # 5. Matricular Aluno, Lançar Notas e Calcular Média
  soma_notas_finais = 0
  
  turmas.each do |turma|
    # Cria Matrícula
    matricula = Matricula.create!(
      aluno: aluno,
      turma: turma,
      situacao: "Cursando", # Será atualizado abaixo
      frequencia: rand(70..100) # Frequência aleatória entre 70% e 100%
    )

    media_do_aluno_na_turma = 0

    # Lança notas para cada avaliação da turma
    turma.avaliacoes.each do |avaliacao|
      # Gera uma nota aleatória entre 4.0 e 10.0 para não ter muitos reprovados
      nota_tirada = (rand(40..100) / 10.0) 
      
      Nota.create!(
        matricula: matricula,
        avaliacao: avaliacao,
        valor: nota_tirada
      )

      # Acumula para a média (Nota * Peso / 10)
      media_do_aluno_na_turma += (nota_tirada * avaliacao.peso) / 10.0
    end

    # Define situação final
    situacao_final = media_do_aluno_na_turma >= 6.0 ? "Aprovado" : "Reprovado"
    
    # Atualiza a matrícula com a nota final e situação
    matricula.update!(
      nota_final: media_do_aluno_na_turma.round(2),
      situacao: situacao_final
    )
    
    soma_notas_finais += media_do_aluno_na_turma
  end

  # Cálculo do IRA (Média das médias)
  ira = soma_notas_finais / turmas.count
  puts "   -> Aluno: #{aluno.nome} | IRA: #{ira.round(2)}"
end

puts "✅ Seed finalizado com sucesso! Usuário padrão: matricula '20241000' / senha 'senha123'"