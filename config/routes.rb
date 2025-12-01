Rails.application.routes.draw do
  get 'biblioteca', to: "biblioteca#index"
  
  get 'financeiro', to: "financeiro#index"
  get 'aluno_online', to: "aluno_online#index"
  get 'disciplinas', to: "disciplinas#index"
  
  #Area de Login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #Solicitações
  get 'solicitacoes', to: 'solicitacoes#index'
  
  # Paginas Estaticas
  get 'sobre', to: "sobrelog#index"
  get 'contato', to: "contato#index"
  get 'ajuda_login', to: "ajuda_login#index"
  
  
  #Perfil do aluno
  get 'perfil', to: 'perfil#edit'
  patch 'perfil', to: 'perfil#update'
  patch 'perfil/password', to: 'perfil#update_password'
  
  #ambiente virtual
  get 'ambiente_virtual', to: "ambiente_virtual#index"
  
  get 'solicitar_boleto', to: "solicitar_boleto#index"
  post 'solicitar_boleto', to: 'financeiro#solicitar_boleto'
  
  get 'enviar_solicitacao', to: "enviar_solicitacao#index"
  get 'baixar_documento', to: "baixar_documento#index"
  
  # root "posts#index"
  root "dashboard#index"
end
