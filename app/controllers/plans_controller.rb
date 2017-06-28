class PlansController < ApplicationController

  def search
    @plans = Plan.search(params[:search_param], current_user.medical_records)
    if @plans
      render partial: "plans/lookup"
    else
      render status: :not_found, nothing: true
    end
  end

end
