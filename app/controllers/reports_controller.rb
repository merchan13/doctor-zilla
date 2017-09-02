class ReportsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create, :select_data, :index]
  before_action :set_selected_options, only: [:new]
  before_action :set_report, only: [:show, :download]
  respond_to :docx

  def index
    @reports = @record.reports.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def new
    @report = @record.reports.new
    @data = set_description_text(@options)

    if !params[:attachments].nil?
      @attachments = set_attachments(params[:attachments])
    end

  end

  def create
    Report.transaction do
      @report = @record.reports.create(description: params[:description], report_type: 'Informe Médico')

      if !params[:attachments].nil?
        params[:attachments].each do |a|
          @report.attachments << Attachment.find(a)
        end
      end

      if @report.save
        flash[:success] = "Nuevo informe creado"
        redirect_to report_path(@report)
      else
        flash[:error] = "Errores en la generación del informe. Por favor verifique que la información es correcta, recuerde que la descripción no puede estar vacía."
        render 'select_data'
      end
    end
  end

  def show
    @record = @report.medical_record
  end

  def select_data
  end

  def download
    respond_to do |format|
      format.docx do
        render docx: 'download', filename: "informe_#{@report.medical_record.last_name.gsub(/ /, "")}_#{@report.id}.docx"
      end
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

    def report_params
      params.require(:report).permit( :description, :report_type )
    end

    def set_selected_options
      @options =  Hash.new
      @options = {  "basic"             => false,
                    "last_consultation" => false,
                    "weight"            => false,
                    "height"            => false,
                    "pressure"          => false,
                    "plan"              => false,
                    "operative_note"    => false,
                    "family_bg"         => false,
                    "allergy_bg"        => false,
                    "diabetes_bg"       => false,
                    "asthma_bg"         => false,
                    "heart_bg"          => false,
                    "medicine_bg"       => false,
                    "surgical_bg"       => false,
                    "other_bg"          => false,
                    "head_neck_pe"      => false,
                    "chest_pe"          => false,
                    "abdomen_pe"        => false,
                    "genitals_pe"       => false,
                    "soft_parts_pe"     => false,
                    "extremities_pe"    => false,
                    "vascular_pe"       => false,
                    "skin_pe"           => false,
                    "mamma_pe"          => false,
                    "others_pe"         => false
                  }

      @options["basic"]             = true if params[:basic]              == '1'
      @options["last_consultation"] = true if params[:last_consultation]  == '1'
      @options["weight"]            = true if params[:weight]             == '1'
      @options["height"]            = true if params[:height]             == '1'
      @options["pressure"]          = true if params[:pressure]           == '1'
      @options["plan"]              = true if params[:plan]               == '1'
      @options["operative_note"]    = true if params[:operative_note]     == '1'
      @options["family_bg"]         = true if params[:family_bg]          == '1'
      @options["allergy_bg"]        = true if params[:allergy_bg]         == '1'
      @options["diabetes_bg"]       = true if params[:diabetes_bg]        == '1'
      @options["asthma_bg"]         = true if params[:asthma_bg]          == '1'
      @options["heart_bg"]          = true if params[:heart_bg]           == '1'
      @options["medicine_bg"]       = true if params[:medicine_bg]        == '1'
      @options["surgical_bg"]       = true if params[:surgical_bg]        == '1'
      @options["other_bg"]          = true if params[:other_bg]           == '1'
      @options["head_neck_pe"]      = true if params[:head_neck_pe]       == '1'
      @options["chest_pe"]          = true if params[:chest_pe]           == '1'
      @options["abdomen_pe"]        = true if params[:abdomen_pe]         == '1'
      @options["genitals_pe"]       = true if params[:genitals_pe]        == '1'
      @options["soft_parts_pe"]     = true if params[:soft_parts_pe]      == '1'
      @options["extremities_pe"]    = true if params[:extremities_pe]     == '1'
      @options["vascular_pe"]       = true if params[:vascular_pe]        == '1'
      @options["skin_pe"]           = true if params[:skin_pe]            == '1'
      @options["mamma_pe"]          = true if params[:mamma_pe]           == '1'
      @options["others_pe"]         = true if params[:others_pe]          == '1'
    end

    def set_description_text(data)
      description = ""

      if @options['basic'] == true
        description += "Información básica:\n #{@record.full_name}, cédula de identidad: #{@record.full_id}, #{@record.age} años de edad.\n"
      end

      if @options['weight'] == true
        description += " Peso: #{@record.physic_data["weight"]}kg\n"
      end

      if @options['height'] == true
        description += " Talla: #{@record.physic_data["height"]}m\n"
      end

      if @options['pressure'] == true
        description += " Tensión: #{@record.physic_data["pressure_s"]}/#{@record.physic_data["pressure_d"]}mm Hg\n"
      end

      description += "\n"

      if @options['last_consultation'] == true
        description += "Consulta médica:
        Motivo de consulta: #{@record.consultations.last.reason.description}
        Enfermedad actual: #{@record.consultations.last.affliction}\n\n"
      end

      backgrounds = set_bg_descriptions
      if backgrounds.length != 15
        description += backgrounds
      end

      physical_exams = set_pe_descriptions
      if physical_exams.length != 16
        description += physical_exams
      end

      if @options['last_consultation'] == true
        description += "Evolución: #{@record.consultations.last.evolution}\n\n"
        description += "Diagnóstico: #{@record.consultations.last.diagnostic.description if !@record.consultations.last.diagnostic.nil?}\n\n"
      end

      if @options['plan'] == true
        description += "Plan: #{@record.plans.last.description}\n\n"
      end

      if @options['operative_note'] == true
        description += "Nota operatoria: #{@record.operative_notes.last.description}
        Hallazgos: #{@record.operative_notes.last.find}\n\n"
      end

      description
    end

    # Set backgrounds descriptions
    def set_bg_descriptions
      backgrounds = "Antecedentes:\n"

      if @options['family_bg'] == true
        backgrounds += " Familiares: #{@record.backgrounds.where(background_type: 'family').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['allergy_bg'] == true
        backgrounds += " Alergias: #{@record.backgrounds.where(background_type: 'allergy').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['diabetes_bg'] == true
        backgrounds += " Diábetes: #{@record.backgrounds.where(background_type: 'diabetes').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['asthma_bg'] == true
        backgrounds += " Asma: #{@record.backgrounds.where(background_type: 'asthma').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['heart_bg'] == true
        backgrounds += " Cardiopatías: #{@record.backgrounds.where(background_type: 'heart').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['medicine_bg'] == true
        backgrounds += " Medciamentos: #{@record.backgrounds.where(background_type: 'medicine').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['surgical_bg'] == true
        backgrounds += " Quirúrgicos: #{@record.backgrounds.where(background_type: 'surgical').first.description.gsub(/\r\n/, ' ')}\n"
      end

      if @options['other_bg'] == true
        backgrounds += " Otros: #{@record.backgrounds.where(background_type: 'other').first.description.gsub(/\r\n/, ' ')}\n"
      end

      backgrounds += "\n"
    end

    # Set physical exams descriptions
    def set_pe_descriptions
      physical_exams = "Exámen físico:\n"

      if @options['head_neck_pe'] == true
        physical_exams += " Cabeza y cuello: #{@record.consultations.last.physical_exams.where(exam_type: 'Head and Neck').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['chest_pe'] == true
        physical_exams += " Torax: #{@record.consultations.last.physical_exams.where(exam_type: 'Chest').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['abdomen_pe'] == true
        physical_exams += " Adbomen: #{@record.consultations.last.physical_exams.where(exam_type: 'Abdomen').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['genitals_pe'] == true
        physical_exams += " Genitales: #{@record.consultations.last.physical_exams.where(exam_type: 'Genitals').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['soft_parts_pe'] == true
        physical_exams += " Partes blandas: #{@record.consultations.last.physical_exams.where(exam_type: 'Soft Parts').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['extremities_pe'] == true
        physical_exams += " Extremidades: #{@record.consultations.last.physical_exams.where(exam_type: 'Extremities').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['vascular_pe'] == true
        physical_exams += " Vascular: #{@record.consultations.last.physical_exams.where(exam_type: 'Vascular').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['skin_pe'] == true
        physical_exams += " Piel: #{@record.consultations.last.physical_exams.where(exam_type: 'Skin').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['mamma_pe'] == true
        physical_exams += " Mamas: #{@record.consultations.last.physical_exams.where(exam_type: 'Mamma').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      if @options['others_pe'] == true
        physical_exams += " Otros: #{@record.consultations.last.physical_exams.where(exam_type: 'Others').first.observation.gsub(/\r\n/, ' ')}\n"
      end

      physical_exams += "\n"
    end

    def set_attachments(attachments)
      attachments_array = Array.new

      attachments.each do |a|
        attachments_array << Attachment.find(a).id
      end

      attachments_array
    end

end
