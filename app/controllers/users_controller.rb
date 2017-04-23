class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def new
    @user = current_user.assistants.new
  end

  def create
    Consultation.transaction do
      new_user = user_params

      new_user[:role] = 'Ayudante'

      @user = current_user.assistants.create(new_user)
      if @user.save
        flash[:success] = "Assistant was created successfully"
        redirect_to administration_path
      else
        render 'new'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "Assistant have been deleted"
    redirect_to administration_path
  end

  private
    def user_params
      params.require(:user).permit( :email, :document, :name, :lastname, :phone, :role, :password,
                                            :password_confirmation, :avatar, :avatar_cache )
    end

    def set_user
      @user = current_user.assistants.find(params[:id])
    end

end
