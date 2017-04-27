class MedicinesController < ApplicationController

  def create
    @medicine = Medicine.create(medicine_params)

    if @medicine.save
      flash[:success] = "New medicine added"
      render json: @medicine
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def medicine_params
      params.require(:medicine).permit( :generic_name, :comercial_name )
    end

end
