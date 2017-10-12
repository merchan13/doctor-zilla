class DrzillaMailer < ActionMailer::Base
  default :from => 'support@doctorzilla.co'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_password_email(user, new_pass)
    @user = user
    @new_pass = new_pass

    mail(
    			:to => @user.email,
    			:subject => 'DoctorrZilla - Recuperación de contraseña'
    		)
  end
end