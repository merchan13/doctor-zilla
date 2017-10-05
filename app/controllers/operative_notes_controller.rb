class OperativeNotesController < ApplicationController
  before_action :set_medical_record,  only: [:new, :create, :index]
  before_action :set_operative_note,  only: [:show, :download, :destroy]
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
        flash[:success] = "Nueva Nota Operatoria creada exitósamente"
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

  def destroy
    OperativeNote.transaction do
      @record = @operative_note.plan.consultation.medical_record

      @operative_note.destroy

      flash[:success] = "Nota Operatoria eliminada"
      redirect_to operative_notes_path(record: @record)
    end
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

    def set_medical_record
      @plan = Plan.find(params[:plan]) unless params[:plan].nil?

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
