class Admin::AdminsController < AdminController
  def index
    @admins = User.admins
    @clients = User.clients
  end
end