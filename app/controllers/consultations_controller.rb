class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create]
  before_action :set_consultation, only: [:edit, :update, :show]

  def index
  end

  def new
    @consultation = @record.consultations.new
    @reason = Reason.new
    @diagnostic = Diagnostic.new
    @procedure = Procedure.new
  end

  def create
    Consultation.transaction do
      @consultation = @record.consultations.create(consultation_params)

      @consultation.add_backgrounds(params[:background])
      @consultation.add_physical_exams(params[:physical], params[:physical_description])

      if !params[:plan][:description].blank?
        @consultation.add_plan(params[:plan])
        if params[:procedures_ids].present?
          @consultation.add_procedure(params[:procedures_ids])
        end
      end

      if @consultation.save
        flash[:success] = "Medical consultation was created successfully"
        redirect_to medical_records_path
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private
    def consultation_params
      params.require(:consultation).permit( :evolution, :note, :affliction, :weight, :height, :temperature, :pressure_s,
                                            :pressure_d, :diagnostic_id, :reason_id )
    end

    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

end
