class OperativeNotesController < ApplicationController
  before_action :set_plan, only: [:new, :create]
  before_action :set_medical_record, only: [:new, :create]

  def new
    @operative_note = OperativeNote.new
    @procedures = @plan.procedures
    @procedure = Procedure.new
  end

  def create
    OperativeNote.transaction do

      PlanProcedure.where(plan_id: @plan.id).each do |pp|
        pp.delete
      end

      params["procedures"].each do |p|
          @plan.plan_procedures.create(plan_id: @plan.id, procedure_id: p)
      end

      @operative_note = OperativeNote.create(operative_note_params)

      @operative_note.plan = @plan

      if @operative_note.save
        flash[:success] = "Operative Note was created successfully"
        redirect_to root_path
      else
        @operative_note = OperativeNote.new
        render 'new'
      end
    end
  end

  private
    def set_plan
      @plan = Plan.find(params[:plan])
    end

    def set_medical_record
      @record = @plan.consultation.medical_record
    end

    def operative_note_params
      params.require(:operative_note).permit( :description, :find )
    end
end
