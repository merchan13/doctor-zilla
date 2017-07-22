class PlansController < ApplicationController
  before_action :set_medical_record, only: [:index]

  def index
    @plans = @record.plans.sort! {|a,b| a.created_at <=> b.created_at}.reverse
  end

  def search
    @filter = params[:filter]
    @plans = Plan.search(params[:search_param], current_user.medical_records)
    if @plans
      render partial: "plans/lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end
end
