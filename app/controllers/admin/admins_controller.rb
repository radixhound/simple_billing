class Admin::AdminsController < ApplicationController
  def index
    @admins = User.admins
    @clients = User.clients
  end
end