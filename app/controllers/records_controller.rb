class RecordsController < ApplicationController
before_action :require_login
before_action :set_record, only: %i[ show edit update destroy record_sound ]

# GET /records or /records.json
def index
  halt :unauthorized unless helpers.allowed?(current_user, 'sound_recorder' )
  @model_name = Dial.model_name.human(count: 2)    
  @pagy, @records = pagy(Record.all)
end

# GET /records/1 or /records/1.json
def show
  halt :unauthorized until helpers.allowed?(current_user, 'sound_recorder' )
  @model_name_single = Record.model_name.human
end

# GET /records/new
def new
  halt :unauthorized unless helpers.allowed?(current_user, 'sound_recorder' )
  @model_name_single = Record.model_name.human 
  @record = Record.new(sound_url: "#{SecureRandom.uuid}")
end

# GET /records/1/edit
def edit
  halt :unauthorized unless helpers.allowed?(current_user, 'sound_recorder' )
  @model_name_single = Record.model_name.human
end

# POST /records or /records.json
def create
  @record = Record.new(record_params)

  respond_to do |format|
    if @record.save
      format.html { redirect_to @record, notice: t('messages.record_created') }
      format.json { render :show, status: :created, location: @record }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @record.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /records/1 or /records/1.json
  def update
    if helpers.allowed?(current_user, 'edit_dial' ) 
      respond_to do |format|
        if @record.update(record_params)
          format.html { redirect_to @record, notice: "Record was successfully updated." }
          format.json { render :show, status: :ok, location: @record }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @record.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end  

  def record_sound
    if helpers.allowed?(current_user, 'sound_recorder' ) && helpers.allowed?(current_user, 'sound_listener' )
      if make_call_for_record(@record)
        redirect_to :records, notice: t('messages.dial_wait_for_record_call')
      else
        redirect_to :records, notice: t('messages.dial_cant_make_sound')
      end 
   else
      halt :unauthorized 
    end   
  end

# DELETE /records/1 or /records/1.json
#def destroy
#  @record.destroy
#  respond_to do |format|
#    format.html { redirect_to records_url, notice: "Record was successfully destroyed." }
#    format.json { head :no_content }
#  end
#end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def record_params
    params.require(:record).permit(:sound_url, :description)
  end

  def make_call_for_record(record)
    if record.update(recorded: true)
      CallRecordSoundJob.perform_later(record.id, current_user.id)
    else
        p '***********************ISSUE HERE********************'
    end
  rescue
    false
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

end