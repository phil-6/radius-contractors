class ApplicationMailer < ActionMailer::Base
  default from: "Radius Contractors <info@radius-contractors.purpleriver.dev>"

  def new_connection_email
    @user = params[:user]
    @other_user = params[:other_user]
    mail(to: @user.email, subject: "#{@other_user.first_name} just connected with you on Radius Contractors")
  end

  layout "mailer"
end
