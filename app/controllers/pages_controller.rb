class PagesController < ApplicationController
  # bloqueo de secretarias
  before_action :doctors_only, only: [:administration]
  skip_before_action :authenticate_user!, only: [:reset_drzilla_password, :send_drzilla_password]

  def doctors_only
    if current_user.role != "Doctor"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      flash[:warning] = "Sólo el Doctor #{doctor.full_name} pueden realizar esa acción"
      redirect_to root_path
    end
  end

  def index
  end

  def home
    @option_selected = params[:page]
    render template: "pages/#{params[:page]}"
  end

  def search
    @model = params[:model]
    @filter = params[:filter]
  end

  def administration
    @assistants = current_user.assistants.paginate(page: params[:page], per_page: 5)
  end

  def reset_drzilla_password
  end

  def send_drzilla_password
    @user = User.where(email: params[:email]).first

    if @user.present?
      @pass = SecureRandom.hex

      @user.password = @pass
      @user.save

      puts @pass

      DrzillaMailer.send_password_email(@user, @pass).deliver

      flash[:success] = "Nueva contraseña enviada exitósamente"

      redirect_to root_path()
    else
      flash[:error] = "El correo que ingresó no esta registrado en DoctorZilla"

      redirect_to reset_drzilla_password_path()
    end

  end

  private
    def user_doctor
      current_user.role == 'Doctor'
    end

end
