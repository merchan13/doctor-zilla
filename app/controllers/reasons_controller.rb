class ReasonsController < ApplicationController

  def create
    Reason.transaction do
      @reason = Reason.create(reason_params)

      if @reason.save
        flash[:success] = "Nuevo Motivo de Consulta agregado"
        render json: @reason
      else
        if @reason.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @reason.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def reason_params
      params.require(:reason).permit( :description )
    end

end
