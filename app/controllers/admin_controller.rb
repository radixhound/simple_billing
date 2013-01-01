class AdminController < ApplicationController
  layout 'admin'
  before_filter :login_required, :admins_only
end
