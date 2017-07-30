class InsurancesController < ApplicationController

  def create
    Insurance.transaction do
      @insurance = Insurance.create(insurance_params)

      if @insurance.save
        flash[:success] = "Nuevo Seguro agregado"
        render json: @insurance
      else
        if @insurance.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @insurance.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def insurance_params
      params.require(:insurance).permit( :name )
    end

end
