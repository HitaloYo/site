# db/seeds.rb
puts "🌱 Iniciando o seed do Portal Acadêmico..."

# 1. Limpeza do Banco de Dados (Ordem inversa para respeitar Foreign Keys)
puts "🗑️  Limpando dados existentes..."

# Limpar tabelas em ordem correta
[
  Nota, Avaliacao, Frequencia, Financeiro, Solicitacao, DestinatarioAviso, Aviso,
  Calendario, Matricula, Turma, Disciplina, Professor, Aluno
].each do |model|
  model.destroy_all if defined?(model) && model.respond_to?(:destroy_all)
  puts "   → #{model.name} limpo" if defined?(model)
end

# 2. Criando Professores
puts "👨‍🏫 Criando Professores..."
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

# 3. Criando Disciplinas
puts "📚 Criando Disciplinas..."
disciplinas = [
  Disciplina.create!(
    codigo: "CC101",
    nome: "Algoritmos e Lógica de Programação",
    carga_horaria: 80,
    professor: professores[0]
  ),
  Disciplina.create!(
    codigo: "CC102",
    nome: "Cálculo Diferencial e Integral",
    carga_horaria: 60,
    professor: professores[1]
  ),
  Disciplina.create!(
    codigo: "CC103",
    nome: "Banco de Dados I",
    carga_horaria: 60,
    professor: professores[3]
  ),
  Disciplina.create!(
    codigo: "CC104",
    nome: "Engenharia de Software",
    carga_horaria: 60,
    professor: professores[2]
  ),
  Disciplina.create!(
    codigo: "CC105",
    nome: "Redes de Computadores",
    carga_horaria: 60,
    professor: professores[4]
  ),
  Disciplina.create!(
    codigo: "CC106",
    nome: "Estruturas de Dados",
    carga_horaria: 60,
    professor: professores[0]
  ),
  Disciplina.create!(
    codigo: "CC107",
    nome: "Sistemas Operacionais",
    carga_horaria: 60,
    professor: professores[2]
  ),
  Disciplina.create!(
    codigo: "CC108",
    nome: "Inteligência Artificial",
    carga_horaria: 60,
    professor: professores[0]
  )
]

# 4. Criando Turmas
puts "🏫 Criando Turmas..."
turmas = []

disciplinas.each_with_index do |disciplina, index|
  2.times do |turma_num|
    turma = Turma.create!(
      disciplina: disciplina,
      codigo_turma: "#{disciplina.codigo}T#{turma_num + 1}",
      semestre: 1,
      ano: 2024,
      vagas_totais: 40,
      vagas_ocupadas: 0
    )
    turmas << turma
    
    # Criar avaliações para cada turma
    tipos_avaliacao = [
      { tipo: "Prova 1", peso: 3.0 },
      { tipo: "Prova 2", peso: 3.0 },
      { tipo: "Trabalho Prático", peso: 2.0 },
      { tipo: "Projeto Final", peso: 2.0 }
    ]
    
    tipos_avaliacao.each_with_index do |avaliacao, av_index|
      Avaliacao.create!(
        turma: turma,
        tipo: avaliacao[:tipo],
        descricao: "#{avaliacao[:tipo]} - #{disciplina.nome}",
        peso: avaliacao[:peso],
        data_avaliacao: Date.today - (3 - av_index).months
      )
    end
  end
end

# 5. Criando Alunos com Perfil Completo
puts "🎓 Criando 15 Alunos com Perfil Completo..."

cursos = ["Ciência da Computação", "Engenharia de Software", "Sistemas de Informação", "Análise e Desenvolvimento de Sistemas"]
periodos = ["1º", "2º", "3º", "4º", "5º", "6º"]
turnos = ["Matutino", "Vespertino", "Noturno"]
unidades = ["Campus Central", "Campus Norte", "Campus Sul"]
estados = ["SP", "RJ", "MG", "RS", "PR"]
cidades_sp = ["São Paulo", "Campinas", "São José dos Campos", "Santos", "Ribeirão Preto"]
racas = ["Branca", "Preta", "Parda", "Amarela", "Indígena"]
estados_civil = ["Solteiro(a)", "Casado(a)", "Divorciado(a)", "Viúvo(a)"]

alunos = []

15.times do |i|
  curso = cursos[i % cursos.length]
  periodo = periodos[i % periodos.length]
  turno = turnos[i % turnos.length]
  estado = estados[i % estados.length]
  cidade = estado == "SP" ? cidades_sp[i % cidades_sp.length] : "Cidade #{i + 1}"
  
  aluno = Aluno.create!(
    # Dados Básicos (Obrigatórios)
    matricula: "2024#{1000 + i}",
    nome: [
      "João Pedro Silva", "Maria Eduarda Santos", "Carlos Alberto Oliveira", 
      "Ana Carolina Pereira", "Roberto Almeida Costa", "Fernanda Lima Rodrigues",
      "Lucas Mendes Souza", "Juliana Andrade Rocha", "Ricardo Nunes Ferreira",
      "Patrícia Gomes Martins", "Bruno Costa Silva", "Amanda Santos Alves",
      "Diego Pereira Lima", "Camila Rodrigues Souza", "Marcos Vinicius Almeida"
    ][i],
    email: "aluno#{20241000 + i}@instituto.edu.br",
    password: "senha123",
    cpf: "#{10000000000 + i}", # CPF numérico
    data_nascimento: Date.new(1995 + (i % 10), (i % 12) + 1, (i % 28) + 1),
    data_criacao: DateTime.now - (i % 365).days,
    ativo: i < 13, # 13 ativos, 2 inativos
    curso: curso,
    
    # Perfil Pessoal
    cor_raca: racas[i % racas.length],
    estado_civil: estados_civil[i % estados_civil.length],
    sexo: i.even? ? "Masculino" : "Feminino",
    estado_nascimento: estado,
    cidade_nascimento: cidade,
    
    # Documentação
    tipo_documento: "RG",
    numero_documento: "#{40000000 + i}",
    data_expedicao: Date.today - (5 + i % 10).years,
    orgao_emissor: "SSP",
    uf_emissao: estado,
    nome_pai: "Pai do #{['João', 'Maria', 'Carlos', 'Ana', 'Roberto'][i % 5]}",
    nome_mae: "Mãe do #{['João', 'Maria', 'Carlos', 'Ana', 'Roberto'][i % 5]}",
    
    # Contato
    ddd: ["11", "21", "31", "41", "51"][i % 5],
    celular: "#{["119", "219", "319", "419", "519"][i % 5]}9#{'%07d' % (8000000 + i)}",
    
    # Endereço
    cep: "#{'%08d' % (1000000 + i * 1000)}",
    logradouro: ["Rua das Flores", "Avenida Paulista", "Rua da Consolação", 
                 "Avenida Brasil", "Rua 7 de Setembro"][i % 5],
    numero: "#{100 + i}",
    bairro: ["Centro", "Jardins", "Moema", "Pinheiros", "Vila Mariana"][i % 5],
    cidade: cidade,
    estado: estado,
    
    # Acadêmico
    periodo: periodo,
    turno: turno,
    unidade: unidades[i % unidades.length]
  )
  
  alunos << aluno
  
  # 6. Matricular Aluno em Turmas Aleatórias
  puts "   📝 Matriculando #{aluno.nome} em turmas..."
  
  turmas_do_aluno = turmas.sample(4) # Cada aluno em 4 turmas
  
  turmas_do_aluno.each do |turma|
    # Atualizar vagas ocupadas
    turma.update!(vagas_ocupadas: turma.vagas_ocupadas + 1)
    
    # Criar matrícula
    matricula = Matricula.create!(
      aluno: aluno,
      turma: turma,
      situacao: "Cursando",
      frequencia: rand(70..100),
      nota_final: nil # Será calculada abaixo
    )
    
    # 7. Lançar Notas para cada Avaliação
    total_pontos = 0
    total_peso = 0
    
    turma.avaliacoes.each do |avaliacao|
      # Gerar nota baseada no desempenho do aluno
      base_nota = rand(5.0..10.0)
      
      # Ajustar baseado no "esforço" simulado
      nota_ajustada = case i % 10
      when 0..2 then base_nota * 0.9  # Alunos com dificuldade
      when 3..7 then base_nota        # Alunos médios
      else base_nota * 1.1           # Alunos acima da média
      end
      
      nota_ajustada = [nota_ajustada, 10.0].min.round(2)
      
      # Criar nota
      Nota.create!(
        matricula: matricula,
        avaliacao: avaliacao,
        valor: nota_ajustada
      )
      
      # Acumular para cálculo da média final
      total_pontos += nota_ajustada * avaliacao.peso
      total_peso += avaliacao.peso
    end
    
    # Calcular média final
    if total_peso > 0
      media_final = (total_pontos / total_peso).round(2)
      
      # Determinar situação baseada na média e frequência
      situacao_final = if media_final >= 6.0 && matricula.frequencia >= 75
        "Aprovado"
      elsif media_final >= 4.0 && matricula.frequencia >= 75
        "Recuperação"
      else
        "Reprovado"
      end
      
      # Atualizar matrícula com nota final e situação
      matricula.update!(
        nota_final: media_final,
        situacao: situacao_final
      )
    end
    
    # 8. Criar Registros de Frequência
    (1..15).each do |dia|
      presente = rand(100) < 85 # 85% de presença em média
      Frequencia.create!(
        matricula: matricula,
        data: Date.today - (15 - dia).days,
        presente: presente
      )
    end
  end
end

# 9. Criar Dados Financeiros
puts "💰 Criando Dados Financeiros..."
alunos.each_with_index do |aluno, i|
  # Criar 3 cobranças por aluno
  3.times do |j|
    vencimento = Date.today - (j * 30).days
    pago = rand(100) < 70 # 70% de chance de estar pago
    
    Financeiro.create!(
      aluno: aluno,
      descricao: "Mensalidade #{['Janeiro', 'Fevereiro', 'Março'][j]} 2024",
      valor: 850.00,
      data_vencimento: vencimento,
      data_pagamento: pago ? vencimento + rand(5) : nil,
      status: pago ? "Pago" : ["Pendente", "Atrasado"].sample,
      tipo: "Mensalidade"
    )
  end
end

# 10. Criar Solicitações
puts "📋 Criando Solicitações..."
tipos_solicitacao = [
  "Declaração de Matrícula",
  "Histórico Acadêmico",
  "Atestado de Frequência",
  "Rematrícula",
  "Trancamento de Disciplina"
]

alunos.sample(8).each do |aluno|
  Solicitacao.create!(
    aluno: aluno,
    tipo: tipos_solicitacao.sample,
    descricao: "Solicitação automática gerada pelo seed",
    status: ["Pendente", "Em Processamento", "Concluído"].sample,
    data_criacao: DateTime.now - rand(30).days,
    data_atualizacao: DateTime.now - rand(10).days
  )
end

# 11. Criar Calendário Acadêmico
puts "📅 Criando Calendário Acadêmico..."
eventos = [
  { titulo: "Início do Semestre", inicio: Date.new(2024, 2, 5), fim: Date.new(2024, 2, 5), tipo: "Acadêmico" },
  { titulo: "Recesso Carnaval", inicio: Date.new(2024, 2, 12), fim: Date.new(2024, 2, 14), tipo: "Feriado" },
  { titulo: "Prova P1", inicio: Date.new(2024, 4, 1), fim: Date.new(2024, 4, 5), tipo: "Avaliação" },
  { titulo: "Semana de Provas", inicio: Date.new(2024, 6, 10), fim: Date.new(2024, 6, 14), tipo: "Avaliação" },
  { titulo: "Férias de Julho", inicio: Date.new(2024, 7, 1), fim: Date.new(2024, 7, 31), tipo: "Recesso" },
  { titulo: "Formatura", inicio: Date.new(2024, 12, 15), fim: Date.new(2024, 12, 15), tipo: "Evento" }
]

eventos.each do |evento|
  Calendario.create!(
    titulo: evento[:titulo],
    descricao: "Evento acadêmico do calendário 2024",
    data_inicio: evento[:inicio],
    data_fim: evento[:fim],
    tipo: evento[:tipo],
    recorrente: evento[:tipo] == "Feriado"
  )
end

# 12. Criar Avisos
puts "📢 Criando Avisos..."
avisos = [
  {
    autor: professores.sample,
    titulo: "Aviso Importante: Mudança na Biblioteca",
    conteudo: "A biblioteca estará fechada para reforma entre os dias 15 e 30 de março. Durante este período, utilize o acervo digital.",
    data_publicacao: DateTime.now - 5.days,
    importante: true
  },
  {
    autor: professores.sample,
    titulo: "Novo Laboratório de Informática",
    conteudo: "Informamos a inauguração do novo laboratório de informática no bloco C. Agende seu horário com a secretaria.",
    data_publicacao: DateTime.now - 2.days,
    importante: false
  },
  {
    autor: professores.sample,
    titulo: "Prazo de Matrícula 2024.2",
    conteudo: "O prazo para matrícula no segundo semestre de 2024 vai até 30 de junho. Não perca o prazo!",
    data_publicacao: DateTime.now - 1.day,
    importante: true
  }
]

avisos.each do |aviso_data|
  aviso = Aviso.create!(
    autor: aviso_data[:autor],
    titulo: aviso_data[:titulo],
    conteudo: aviso_data[:conteudo],
    data_publicacao: aviso_data[:data_publicacao],
    data_expiracao: aviso_data[:data_publicacao] + 30.days,
    importante: aviso_data[:importante]
  )
  
  # Associar aviso a alguns alunos
  alunos.sample(5).each do |aluno|
    DestinatarioAviso.create!(
      aviso: aviso,
      aluno: aluno,
      lido: rand(100) < 50
    )
  end
end

# 13. Criar Aluno Admin para Testes
puts "👑 Criando Aluno Administrador para Testes..."
admin = Aluno.create!(
  matricula: "20240000",
  nome: "Administrador do Sistema",
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
  
  # Perfil
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
  
  # Contato
  ddd: "11",
  celular: "11999990000",
  
  # Endereço
  cep: "00000000",
  logradouro: "Rua Administrativa",
  numero: "1",
  bairro: "Centro",
  cidade: "São Paulo",
  estado: "SP"
)

# Matricular admin em algumas turmas
turmas.sample(3).each do |turma|
  Matricula.create!(
    aluno: admin,
    turma: turma,
    situacao: "Aprovado",
    frequencia: 95,
    nota_final: rand(8.0..10.0).round(2)
  )
end

puts ""
puts "✅ SEED COMPLETADO COM SUCESSO!"
puts "=========================================="
puts "📊 RESUMO DO BANCO DE DADOS:"
puts "   👨‍🎓 Alunos: #{Aluno.count} (1 admin + 15 regulares)"
puts "   👨‍🏫 Professores: #{Professor.count}"
puts "   📚 Disciplinas: #{Disciplina.count}"
puts "   🏫 Turmas: #{Turma.count}"
puts "   📝 Matrículas: #{Matricula.count}"
puts "   📊 Avaliações: #{Avaliacao.count}"
puts "   🔢 Notas: #{Nota.count}"
puts "   📅 Frequências: #{Frequencia.count}"
puts "   💰 Financeiros: #{Financeiro.count}"
puts "   📋 Solicitações: #{Solicitacao.count}"
puts "   📢 Avisos: #{Aviso.count}"
puts ""
puts "🔑 ACESSOS PARA TESTE:"
puts "   👑 Admin: matrícula '20240000' / senha 'admin123'"
puts "   👨‍🎓 Aluno 1: matrícula '20241000' / senha 'senha123'"
puts "   👨‍🎓 Aluno 2: matrícula '20241001' / senha 'senha123'"
puts ""
puts "🌐 Sistema pronto para uso! Acesse o portal e faça login."