class DashboardController < ApplicationController
  layout 'authenticated'
  before_action :require_login
  
  def index
    @aluno = current_aluno
  
  end  
end