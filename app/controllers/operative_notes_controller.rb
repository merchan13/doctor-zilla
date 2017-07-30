class OperativeNotesController < ApplicationController
  before_action :set_medical_record,  only: [:new, :create, :index]
  before_action :set_plan,            only: [:new, :create]
  before_action :set_operative_note,  only: [:show, :download]
  respond_to :docx

  def index
    @operative_notes = @record.operative_notes.sort! {|a,b| a.created_at <=> b.created_at}.reverse
  end

  def new
    @operative_note = OperativeNote.new
    @procedures = @plan.procedures unless @plan.nil?
    @procedure = Procedure.new
  end

  def create
    OperativeNote.transaction do
      if @plan.nil?
        @reason = Reason.where(description: "Plan operatorio de emergencia").take
        @consultation = Consultation.create(reason: @reason, medical_record: @record)
        @plan = Plan.create(description: "Plan operatorio de emergencia", emergency: true, consultation: @consultation)
      else
        PlanProcedure.where(plan_id: @plan.id).each do |pp|
          pp.delete
        end
      end

      params["procedures"].each do |p|
          @plan.plan_procedures.create(plan_id: @plan.id, procedure_id: p)
      end

      @operative_note = OperativeNote.create(operative_note_params)

      @operative_note.plan = @plan

      if @operative_note.save
        flash[:success] = "Operative Note was created successfully"
        redirect_to operative_note_path(@operative_note)
      else
        @operative_note = OperativeNote.new
        render 'new'
      end
    end
  end

  def show
    # ...
  end

  def download
    respond_to do |format|
      format.docx do
        render docx: 'download', filename: "notaOperatoria_#{@record.last_name.gsub(/ /, "")}_#{@operative_note.id}.docx"
      end
    end
  end

  private
    def set_operative_note
      @operative_note = OperativeNote.find(params[:id])
      @plan = @operative_note.plan
      @record = @plan.consultation.medical_record
      @procedures = @plan.procedures
    end

    def set_plan
      @plan = Plan.find(params[:plan]) unless params[:plan].nil?
    end

    def set_medical_record
      if @plan.nil?
        @record = MedicalRecord.find(params[:record])
      else
        @record = @plan.consultation.medical_record
      end
    end

    def operative_note_params
      params.require(:operative_note).permit( :description, :find, :diagnostic )
    end
end
