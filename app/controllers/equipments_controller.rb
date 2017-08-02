class EquipmentsController < ApplicationController

  def create
    Equipment.transaction do
      @equipment = Equipment.create(equipment_params)

      if @equipment.save
        flash[:success] = "Nuevo Equipo agregado"
        render json: @equipment
      else
        if @equipment.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @equipment.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def equipment_params
      params.require(:equipment).permit( :name )
    end

end
