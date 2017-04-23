class PagesController < ApplicationController

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
