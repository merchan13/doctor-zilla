class ReportsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create, :select_data]
  before_action :set_selected_options, only: [:new]
  before_action :set_report, only: [:show]

  def new
    @report = @record.reports.new
    @data = set_description_text(@options)
  end

  def create
    Report.transaction do
      @report = @record.reports.create(report_params)
      if @report.save
        flash[:success] = "New Report added"
        redirect_to root_path
      else
        render 'select_data'
      end
    end
  end

  def show
    # ...
  end

  def select_data
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
      basic = "Información básica:\n #{@record.full_name}, cédula de identidad: #{@record.full_id}, #{@record.age} años de edad.\n"

      weight = "Peso: #{@record.physic_data["weight"] if @record.physic_data["weight"] > 0}kg\n"

      height = "Talla: #{@record.physic_data["height"] if @record.physic_data["height"] > 0}m\n"

      pressure = "Tensión: #{@record.physic_data["pressure_s"]}/#{@record.physic_data["pressure_d"]}mm Hg\n"

      consultation = "Consulta médica:
      Motivo de consulta: #{@record.consultations.last.reason.description}
      Enfermedad actual: #{@record.consultations.last.affliction}
      Evolución: #{@record.consultations.last.evolution}
      Diagnóstico: #{@record.consultations.last.diagnostic.description if !@record.consultations.last.diagnostic.nil?}\n\n"

      backgrounds = set_bg_descriptions

      physical_exams = set_pe_descriptions

      plan ="Plan: #{@record.plans.last.description}\n\n"

      operative_note = "Nota operatoria: #{@record.operative_notes.last.description}, hallazgos: #{@record.operative_notes.last.find}\n\n"

      # arreglar este desastre!
      description = "#{basic if @options['basic'] == true} #{weight if @options['weight'] == true} #{height if @options['height'] == true} #{pressure if @options['pressure'] == true}\n#{consultation if @options['last_consultation'] == true}#{backgrounds if backgrounds.length != 15}#{physical_exams if physical_exams.length != 16}#{plan if @options['plan'] == true}#{operative_note if @options['operative_note'] == true}"
      description
    end

    # Set backgrounds descriptions
    def set_bg_descriptions
      backgrounds = "Antecedentes:\n"

      if @options['family_bg'] == true
        backgrounds += " Familiares: #{@record.backgrounds.where(background_type: 'family').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'family').first.nil?}\n"
      end

      if @options['allergy_bg'] == true
        backgrounds += " Alergias: #{@record.backgrounds.where(background_type: 'allergy').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'allergy').first.nil?}\n"
      end

      if @options['diabetes_bg'] == true
        backgrounds += " Diábetes: #{@record.backgrounds.where(background_type: 'diabetes').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'diabetes').first.nil?}\n"
      end

      if @options['asthma_bg'] == true
        backgrounds += " Asma: #{@record.backgrounds.where(background_type: 'asthma').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'asthma').first.nil?}\n"
      end

      if @options['heart_bg'] == true
        backgrounds += " Cardiopatías: #{@record.backgrounds.where(background_type: 'heart').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'heart').first.nil?}\n"
      end

      if @options['medicine_bg'] == true
        backgrounds += " Medciamentos: #{@record.backgrounds.where(background_type: 'medicine').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'medicine').first.nil?}\n"
      end

      if @options['surgical_bg'] == true
        backgrounds += " Quirúrgicos: #{@record.backgrounds.where(background_type: 'surgical').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'surgical').first.nil?}\n"
      end

      if @options['other_bg'] == true
        backgrounds += " Otros: #{@record.backgrounds.where(background_type: 'other').first.description.gsub(/\r\n/, ' ') if !@record.backgrounds.where(background_type: 'other').first.nil?}\n"
      end

      backgrounds += "\n"
    end

    # Set physical exams descriptions
    def set_pe_descriptions
      physical_exams = "Exámen físico:\n"

      if @options['head_neck_pe'] == true
        head_neck_pe = " Cabeza y cuello: #{@record.consultations.last.physical_exams.where(exam_type: 'Head and Neck').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Head and Neck').first.nil?}\n"
      end

      if @options['chest_pe'] == true
        chest_pe = " Torax: #{@record.consultations.last.physical_exams.where(exam_type: 'Chest').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Chest').first.nil?}\n"
      end

      if @options['abdomen_pe'] == true
        abdomen_pe = " Adbomen: #{@record.consultations.last.physical_exams.where(exam_type: 'Abdomen').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Abdomen').first.nil?}\n"
      end

      if @options['genitals_pe'] == true
        genitals_pe = " Genitales: #{@record.consultations.last.physical_exams.where(exam_type: 'Genitals').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Genitals').first.nil?}\n"
      end

      if @options['soft_parts_pe'] == true
        soft_parts_pe = " Partes blandas: #{@record.consultations.last.physical_exams.where(exam_type: 'Soft Parts').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Soft Parts').first.nil?}\n"
      end

      if @options['extremities_pe'] == true
        extremities_pe = " Extremidades: #{@record.consultations.last.physical_exams.where(exam_type: 'Extremities').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Extremities').first.nil?}\n"
      end

      if @options['vascular_pe'] == true
        vascular_pe = " Vascular: #{@record.consultations.last.physical_exams.where(exam_type: 'Vascular').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Vascular').first.nil?}\n"
      end

      if @options['skin_pe'] == true
        skin_pe = " Piel: #{@record.consultations.last.physical_exams.where(exam_type: 'Skin').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Skin').first.nil?}\n"
      end

      if @options['mamma_pe'] == true
        mamma_pe = " Mamas: #{@record.consultations.last.physical_exams.where(exam_type: 'Mamma').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Mamma').first.nil?}\n"
      end

      if @options['others_pe'] == true
        others_pe = " Otros: #{@record.consultations.last.physical_exams.where(exam_type: 'Others').first.observation.gsub(/\r\n/, ' ') if !@record.consultations.last.physical_exams.where(exam_type: 'Others').first.nil?}\n"
      end

      physical_exams += "\n"
    end

end
