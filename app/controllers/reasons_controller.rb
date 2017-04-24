class ReasonsController < ApplicationController

  def create
    @reason = Reason.create(reason_params)

    if @reason.save
      flash[:success] = "New reason added"
      render json: @reason
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def reason_params
      params.require(:reason).permit( :description )
    end

end
