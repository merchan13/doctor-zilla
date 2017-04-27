class MedicalRecordsController < ApplicationController
  before_action :set_record, only: [:edit, :update, :show]

  def index
    if current_user.role == "Doctor"
      @records = current_user.medical_records.paginate(page: params[:page], per_page: 20)
    elsif current_user.role == "Ayudante"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      @records = doctor.medical_records.paginate(page: params[:page], per_page: 20)
    elsif current_user.role == "Administrador"
      @records = MedicalRecord.all.paginate(page: params[:page], per_page: 20)
    end
  end

  def new
    @record = current_user.medical_records.new
    @occupation = Occupation.new
    @insurance = Insurance.new
  end

  def create
    @record = current_user.medical_records.create(record_params)
    if @record.save
      flash[:success] = "Medical record was created successfully"
      redirect_to medical_records_path
    else
      @occupation = Occupation.new
      @insurance = Insurance.new
      render 'new'
    end
  end

  def edit
  end

  def update
    if @record.update(record_params)
      flash[:success] = "Medical record data was successfully updated"
      redirect_to medical_record_path(@record)
    else
      @occupation = Occupation.new
      @insurance = Insurance.new
      render 'edit'
    end
  end

  def show
    # @record_x = @record.x.paginate(page: params[:page], per_page: 5)
  end

  def search
    @filter = params[:filter]
    @records = current_user.medical_records.search(params[:search_param])
    if @records
      render partial: "medical_records/lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  private
    def record_params
      params.require(:medical_record).permit( :document, :document_type, :first_consultation_date, :name, :last_name,
                                              :birth_date, :gender, :phone_number, :cellphone_number, :address, :email,
                                              :referred_by, :profile_picture, :representative_document, :occupation_id,
                                              :insurance_id )
    end

    def set_record
      @record = current_user.medical_records.find(params[:id])
    end

end
