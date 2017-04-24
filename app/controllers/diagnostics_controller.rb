class DiagnosticsController < ApplicationController

  def create
    @diagnostic = Diagnostic.create(diagnostic_params)

    if @diagnostic.save
      flash[:success] = "New diagnostic added"
      render json: @diagnostic
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def diagnostic_params
      params.require(:diagnostic).permit( :description )
    end

end
