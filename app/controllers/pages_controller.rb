class PagesController < ApplicationController
  # bloqueo de secretarias
  before_action :doctors_only, only: [:administration]

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

  private
    def user_doctor
      current_user.role == 'Doctor'
    end

end
