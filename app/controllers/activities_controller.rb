class ActivitiesController < ApplicationController

  def general
    #@option_selected = params[:page]
    #render template: "pages/#{params[:page]}"
  end

  private
    def user_doctor
      current_user.role == 'Doctor'
    end
end
