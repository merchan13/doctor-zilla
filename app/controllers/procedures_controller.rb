class ProceduresController < ApplicationController

  def create
    @procedure = Procedure.create(procedure_params)

    if @procedure.save
      flash[:success] = "New procedure added"
      render json: @procedure
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def procedure_params
      params.require(:procedure).permit( :name, :description )
    end

end
