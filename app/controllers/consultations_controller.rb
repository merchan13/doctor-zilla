class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create]
  before_action :set_consultation, only: [:edit, :update, :show]

  def index
  end

  def new
    @consultation = @record.consultations.new
    @reason = Reason.new
  end

  def create
    Consultation.transaction do
      new_consultation = consultation_params

      new_consultation[:reason_id] = new_reason?(consultation_params[:reason_id])
      new_consultation[:diagnostic_id] = new_diagnostic?(consultation_params[:diagnostic_id])

      @consultation = @record.consultations.create(new_consultation)

      @consultation.add_backgrounds(params[:background])
      @consultation.add_physical_exams(params[:physical], params[:physical_description])

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

    def new_reason?(param)
      if !(param =~ /^[0-9]+$/).present?
        Reason.create(description: param)
        param = Reason.last.id
      else
        param
      end
    end

    def new_diagnostic?(param)
      if !(param =~ /^[0-9]+$/).present?
        Diagnostic.create(description: param)
        param = Diagnostic.last.id
      else
        param
      end
    end

    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

end
