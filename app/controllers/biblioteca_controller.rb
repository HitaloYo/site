class BibliotecaController < ApplicationController
  layout 'authenticated'
  before_action :require_login
  def index
  
  end
end
