class MedicinesController < ApplicationController

  def create
    Medicine.transaction do
      @medicine = Medicine.create(medicine_params)

      if @medicine.save
        flash[:success] = "Nuevo medicamento + administración creado"
        render json: @medicine
      else
        if @medicine.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @medicine.errors.full_messages.first.include? "ya existe"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def medicine_params
      params.require(:medicine).permit( :generic_name, :comercial_name, :dose_way, :dose_presentation, :dose_quantity, :dose_unit )
    end
end
