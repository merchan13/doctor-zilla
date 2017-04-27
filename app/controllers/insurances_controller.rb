class InsurancesController < ApplicationController

  def create
    @insurance = Insurance.create(insurance_params)

    if @insurance.save
      flash[:success] = "New insurance added"
      render json: @insurance
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def insurance_params
      params.require(:insurance).permit( :name )
    end

end
