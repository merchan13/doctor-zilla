class OccupationsController < ApplicationController

  def create
    @occupation = Occupation.create(occupation_params)

    if @occupation.save
      flash[:success] = "New occupation added"
      render json: @occupation
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def occupation_params
      params.require(:occupation).permit( :name )
    end

end
