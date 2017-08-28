class DiagnosticsController < ApplicationController

  def create
    Diagnostic.transaction do
      @diagnostic = Diagnostic.create(diagnostic_params)

      if @diagnostic.save
        flash[:success] = "Nuevo Seguro agregado"
        render json: @diagnostic
      else
        if @diagnostic.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @diagnostic.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def diagnostic_params
      params.require(:diagnostic).permit( :description )
    end

end
