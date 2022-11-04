class DialsController < ApplicationController
  before_action :require_login
  before_action :set_dial, only: %i[ show edit update destroy mass_update record_sound make_calls basic_report unpined_report search]

  # GET /dials or /dials.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_dial' )
    @pagy, @dials = pagy(Dial.allow_dial_list(current_user))
    @model_name = Dial.model_name.human(count: 2)
  end

  def common_report
    halt :unauthorized unless helpers.allowed?(current_user, 'show_common_report' )
    @model_name = Dial.model_name.human(count: 2)

    if params[:common_report_date_start] != ''
     start_date = params[:common_report_date_start].to_date.beginning_of_day 
    else
      start_date =DateTime.now.beginning_of_day
    end

    if  params[:common_report_date_end] != ''
      end_date = params[:common_report_date_end].to_date.end_of_day 
    else
      end_date = DateTime.now.end_of_day
    end

    search_date =  start_date..end_date

    @report_date = search_date

    case params[:date_type]
      when 'false'
        @dials = Dial.allow_dial_list(current_user).dialed.date_by_create(search_date)
      when 'true'
        @dials = Dial.allow_dial_list(current_user).dialed.date_by_update(search_date) 
      else
        halt :unauthorized 
      end
        default_url_options
        render :common_report
  end

  # GET /dials/1 or /dials/1.json
  def show
    halt :unauthorized until helpers.allowed?(current_user, 'show_dial' )
    if Dial.allow_dial_list(current_user).include? @dial
    #@dialsgroups = helpers.dial_groups(current_user)
    @pagy, @dialsgroups = pagy(Group.dial_groups(current_user), items: Rails.configuration.set[:dials_per_page])
    @model_name_single = Dial.model_name.human
    else
      halt :unauthorized 
    end
    session[:dial_id] = @dial.id if @dial
  end

  def basic_report
    if helpers.allowed?(current_user, 'show_basic_report' )
      @model_name_single = Dial.model_name.human
    else
      halt :unauthorized 
    end  
  end

  def unpined_report
    if helpers.allowed?(current_user, 'show_unpined_report' )
      @model_name_single = Dial.model_name.human
    else
      halt :unauthorized 
    end  
  end

  # GET /dials/new  
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_dial' )
    @records = Record.all
    @model_name_single = Dial.model_name.human 
    @dial = Dial.new(sound_url: "#{SecureRandom.uuid}")
  end

  # GET /dials/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_dial' )
    @records = Record.all
    @model_name_single = Dial.model_name.human
  end

  # POST /dials or /dials.json
  def create
    if helpers.allowed?(current_user, 'add_dial' )
      d_s = dial_params.dup
      d_s[:user_id] = current_user.id
      d_s[:record] = Record.find_by(description:  dial_params[:record])
      @dial = Dial.new(d_s)

      respond_to do |format|
        if @dial.save
         format.html { redirect_to @dial, notice: t('messages.dial_created') }
         format.json { render :show, status: :created, location: @dial }
       else
         format.html { render :new, status: :unprocessable_entity }
         format.json { render json: @dial.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end

  # PATCH/PUT /dials/1 or /dials/1.json
  def update
    if helpers.allowed?(current_user, 'edit_dial' ) && @dial.dialed == false
      d_u = dial_params.dup
      d_u[:record] = Record.find_by(description:  dial_params[:record])
      respond_to do |format|
        if @dial.update(d_u)
         format.html { redirect_to @dial, notice: t('messages.dial_updated') }
         format.json { render :show, status: :ok, location: @dial }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dial.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end

  def record_sound
    if helpers.allowed?(current_user, 'sound_recorder' ) && helpers.allowed?(current_user, 'sound_listener' )
      if make_call_for_record(@dial)
        redirect_to :dials, notice: t('messages.dial_wait_for_record_call')
      else
        redirect_to :dials, notice: t('messages.dial_cant_make_sound')
      end 
   else
      halt :unauthorized 
    end   
  end

  def mass_update
    if helpers.allowed?(current_user, 'add_dial_group' ) && helpers.allowed?(current_user, 'delete_dial_group' ) &&  helpers.allowed?(current_user, 'add_dial_user' ) &&  helpers.allowed?(current_user, 'delete_dial_user' ) && @dial.dialed == false    
      logger.warn "It works! #{params.inspect}"

      g_remove = Dialstogroup.where(dial_id: params[:id].to_i)
      if g_remove 
        g_remove.each do |g|
          g.destroy if g.dialed == false
        end       
      end

      params[:group_id].dup.reject { |item| item.blank? }.each do |a|
        Dialstogroup.create(group_id: a, dial_id: params[:id]) # if !params[:user_id].dup.reject { |item| item.blank? }.any?
      end
      
      u_remove = Dialstouser.where(dial_id: params[:id].to_i)
      if u_remove 
        u_remove.each do |u|
          u.destroy if u.dialed == false
        end       
      end
              
      params[:user_id].dup.reject { |item| item.blank? }.each do |a|
        Dialstouser.create(user_id: a, dial_id: params[:id]) # if !params[:group_id].dup.reject { |item| item.blank? }.any?
      end
               
      # redirect_back(fallback_location: root_path)
      respond_to do |format|
        format.html { redirect_to @dial, notice: t('messages.dials_to_group_updated')  }
        format.json { render :show, status: :ok, location: @dial }
      end
    else
      halt :unauthorized 
    end  
  end

  def make_calls
    if helpers.allowed?(current_user, 'dial_runner')
      CallUsersJob.perform_later @dial.id
      CallAfterDialJob.perform_later @dial.id, @dial.user.phone
        respond_to do |format|
        format.html { redirect_to action: :index, notice: t('messages.dial_run') }
        format.json { render :show, status: :ok, location: @dial }
      end    
    else
      halt :unauthorized 
    end     
  end

  # DELETE /dials/1 or /dials/1.json
  def destroy
    if helpers.allowed?(current_user, 'delete_dial_group' ) && @dial.dialed == false
      @dial.destroy
      respond_to do |format|
        format.html { redirect_to dials_url}
        format.json { head :no_content }
      end
    else
      halt :unauthorized 
    end
  end

  def search
    halt :unauthorized unless helpers.allowed?(current_user, 'show_dial' )
      @pagy, @dials = pagy(Group.allow_group_list(current_user)) if params[:search]
      @pagy, @dialsgroups = pagy(Group.search_in_all_fields("#{params[:search]}").dial_groups(current_user), items: Rails.configuration.set[:dials_per_page]*100)
      @model_name = Dial.model_name.human(count: 2)
      @dial =  Dial.find(session[:dial_id]) 
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dial
      @dial = Dial.find(params[:id]) if is_number?(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def dial_params
      params.require(:dial).permit(:sound_url, :description, :group_id, :user_id, :common_report_date_start, :common_report_date_end, :locale, :search, :record)
    end
    
    def make_call_for_record(dial)
      if dial.update(recorded: true)
       CallSingleUserJob.perform_later(dial.id, '')
      else        
        # put error handler here!
      end
    rescue
        false
    end    
    
    def default_url_options(options={})
      { :locale => I18n.locale }
    end          
end
