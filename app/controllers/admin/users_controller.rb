class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: %i[show reset_password]

  def index
    @users = User.order(:created_at)
  end

  def show; end

  def reset_password
    @user.send_reset_password_instructions
    redirect_to admin_user_path(@user), notice: "Password reset email sent."
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
