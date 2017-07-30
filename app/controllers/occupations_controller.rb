class OccupationsController < ApplicationController

  def create
    Occupation.transaction do
      @occupation = Occupation.create(occupation_params)

      if @occupation.save
        flash[:success] = "Nueva profesión agregada"
        render json: @occupation
      else
        if @occupation.errors.full_messages.first.include? "blank"
          render status: 400, nothing: true
        elsif @occupation.errors.full_messages.first.include? "taken"
          render status: 406, nothing: true
        end
      end
    end
  end

  private
    def occupation_params
      params.require(:occupation).permit( :name )
    end

end
