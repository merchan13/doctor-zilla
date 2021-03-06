class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create, :edit, :update]
  before_action :set_consultation, only: [:edit, :update, :show]
  before_action :set_others, only: [:edit, :update, :new, :create]
  before_action :set_attachments, only: [:edit, :update]
  # bloqueo de secretarias
  before_action :doctors_only, only: [:new, :create, :edit, :update]

  def doctors_only
    if current_user.role != "Doctor"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      flash[:warning] = "Sólo el Doctor #{doctor.full_name} pueden realizar esa acción"
      redirect_to medical_record_path(@record)
    end
  end

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

      if !params["diagnostics"].nil?
        params["diagnostics"].each do |d|
            @consultation.consultation_diagnostics.create(diagnostic_id: d)
        end
      end

      if !params[:plan][:description].blank?
        @consultation.add_plan(params[:plan])
        if params[:procedures].present?
          @consultation.add_procedure(params[:procedures])
        end
      end

      if @consultation.save
        record = @consultation.medical_record

        record.updated_at = Time.now.getutc

        record.save

        flash[:success] = "Nueva Consulta Médica creada exitósamente"

        redirect_to medical_record_path(@consultation.medical_record)
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    Consultation.transaction do
      @consultation.update_PE(params[:physical], params[:physical_description])

      if !params["diagnostics"].nil?
        @consultation.update_diagnostics(params["diagnostics"])
      end

      @consultation.updated_at = Time.now.getutc

      if @consultation.update(consultation_params)
        record = @consultation.medical_record

        record.updated_at = Time.now.getutc

        record.save

        flash[:success] = "Consulta Médica actualizada exitósamente"

        redirect_to medical_record_path(@consultation.medical_record)
      else
        render 'edit'
      end
    end
  end

  def show
    # ...
  end

  private
    def consultation_params
      params.require(:consultation).permit( :evolution, :note, :affliction, :weight, :height, :pressure_s,
                                            :pressure_d, :reason_id )
    end

    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

    def set_others
      @reason = Reason.new
      @diagnostic = Diagnostic.new
      @procedure = Procedure.new
      @attachment = Attachment.new
    end

    def set_attachments
      @my_attachments = @record.attachments.paginate(page: params[:page], per_page: 20)
    end

end
