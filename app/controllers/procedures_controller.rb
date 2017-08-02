class ProceduresController < ApplicationController

  def create
    Procedure.transaction do
      @procedure = Procedure.create(procedure_params)

      if @procedure.save
        flash[:success] = "Nuevo Procedimiento Quirúrgico agregado"
        render json: @procedure
      else
        if @procedure.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @procedure.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def procedure_params
      params.require(:procedure).permit( :name, :description )
    end

end
