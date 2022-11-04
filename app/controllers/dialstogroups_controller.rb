class DialstogroupsController < ApplicationController
  before_action :stop_all
  before_action :require_login
  before_action :set_dialstogroup, only: %i[ show edit update destroy ]
  before_action :set_vars

  def set_vars
    @groups = helpers.groups(current_user)
    @dials = current_user.dials.pluck(:description)
  end

  # GET /dialstogroups or /dialstogroups.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_dial_group' )
    @dialstogroups = helpers.allow_dials_to_group_list(current_user)
    @model_name = Dialstogroup.model_name.human(count: 2)
  end

  # GET /dialstogroups/1 or /dialstogroups/1.json
  def show
    halt :unauthorized until helpers.allowed?(current_user, 'show_dial_group' )
    @model_name_single = Dialstogroup.model_name.human
  end

  # TODO all security check!

  # GET /dialstogroups/new
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_dial_group' ) 
    @model_name_single = Dialstogroup.model_name.human
    @dialstogroup = Dialstogroup.new
  end

  # GET /dialstogroups/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_dial_group' )
    @model_name_single = Dialstogroup.model_name.human
  end

  # POST /dialstogroups or /dialstogroups.json
  def create
    if helpers.allowed?(current_user, 'add_dial_group' )
      d_g = dialstogroup_params.dup
      d_g[:group] = Group.find_by(:group => dialstogroup_params[:group])
      d_g[:dial] = Dial.find_by(:description => dialstogroup_params[:dial])
      @dialstogroup = Dialstogroup.new(d_g)

      respond_to do |format|
        if @dialstogroup.save
          format.html { redirect_to @dialstogroup, notice: "Dialstogroup was successfully created." }
          format.json { render :show, status: :created, location: @dialstogroup }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @dialstogroup.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end

  # PATCH/PUT /dialstogroups/1 or /dialstogroups/1.json
  def update
    if helpers.allowed?(current_user, 'edit_dial_group' ) && @dialstogroup.dialed == false
      d_g = dialstogroup_params.dup
      d_g[:group] = Group.find_by(:group => dialstogroup_params[:group])    
      d_g[:dial] = Dial.find_by(:description => dialstogroup_params[:dial])
      respond_to do |format|
        if @dialstogroup.update(d_g)
          format.html { redirect_to @dialstogroup, notice: "Dialstogroup was successfully updated." }
          format.json { render :show, status: :ok, location: @dialstogroup }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dialstogroup.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized
    end
  end

  # DELETE /dialstogroups/1 or /dialstogroups/1.json
  def destroy
    if helpers.allowed?(current_user, 'delete_dial_group' ) && @dialstogroup.dialed == false
      @dialstogroup.destroy
      respond_to do |format|
        format.html { redirect_to dialstogroups_url, notice: "Dialstogroup was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      halt :unauthorized 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialstogroup
      @dialstogroup = Dialstogroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dialstogroup_params
      params.require(:dialstogroup).permit(:group, :dial, :dialed)
    end
    
    def require_login
      unless current_user.present? 
        flash[:error] = t('messages.no_admin_access')
        redirect_to root_path # halts request cycle
      end
    end
    
end
