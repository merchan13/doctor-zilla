class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create]
  before_action :set_consultation, only: [:edit, :update, :show]

  def index
  end

  def new
    @consultation = @record.consultations.new
  end

  def create
    @consultation = @record.consultations.create(consultation_params)
    if @consultation.save
      #@consultation.add_x(params[:consultation][:x])
      flash[:success] = "Medical consultation was created successfully"
      redirect_to medical_records_path
    else
      render 'new'
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
      params.require(:consultation).permit( :evolution, :note, :affliction, :weight, :height, :temperature, :pressure,
                                            :diagnostic_id, :reason_id )
    end

    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end


end
