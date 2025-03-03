class Admin::AdminController < ApplicationController
  before_action :authorize_admin

  # As this grows, these actions could be extracted to other controllers that extend this one.
  def users
    @users = User.all.order(:created_at)
    render template: "admin/users"
  end

  def contractors
    @contractors = Contractor.all
    render template: "admin/contractors"
  end

  private

  def authorize_admin
    redirect_to(root_path) unless current_user&.admin?
  end
end
