class RolesController < ApplicationController
  before_action :require_login
  before_action :set_role, only: %i[ show edit update destroy mass_update ]

  # TODO all securoty check!
  # GET /roles or /roles.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_role' )
    @roles = Role.all
    @model_name = Role.model_name.human(count: 2)
  end

  # GET /roles/1 or /roles/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'show_role' )
    @model_name = Role.model_name.human(count: 2)
    @rules = Rule.all
  end

  # GET /roles/new
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_role' )
    @model_name_single = Role.model_name.human
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_role' )
    @model_name_single = Role.model_name.human
  end

  # POST /roles or /roles.json
  def create
    if helpers.allowed?(current_user, 'add_role' )
      @role = Role.new(role_params)

      respond_to do |format|
        if @role.save
          format.html { redirect_to @role, notice: t('messages.role_created') }
          format.json { render :show, status: :created, location: @role }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    if helpers.allowed?(current_user, 'edit_role' )
      respond_to do |format|
        if @role.update(role_params)
          format.html { redirect_to @role, notice: t('messages.role_updated') }
          format.json { render :show, status: :ok, location: @role }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end      
  end

  def mass_update
     if helpers.allowed?(current_user, 'add_rule' ) && helpers.allowed?(current_user, 'delete_rule' ) 
        logger.warn "It works! #{params.inspect}"
        r_remove = Rolestorule.where(role_id: params[:id].to_i)
        r_remove.destroy_all
        params[:rule_id].dup.reject { |item| item.blank? }.each do |a|
          Rolestorule.create(rule_id: a, role_id: params[:id])
        end
        respond_to do |format|
          format.html { redirect_to @role, notice: t('messages.roles_to_rules_updated') }
          format.json { render :show, status: :ok, location: @role }
        end
      else
        halt :unauthorized 
      end           
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    if helpers.allowed?(current_user, 'delete_role' )
      respond_to do |format|
        if @role.destroy
          format.html { redirect_to roles_url, notice: t('messages.role_deleted') }
          format.json { head :no_content }
        else
          @roles = Role.all
          format.html  { redirect_to roles_url, notice: t('messages.role_cant_be_deleted')  }
          format.json { render json: @role.errors, status: :unprocessable_entity }    
        end 
      end
    else
      halt :unauthorized 
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:role, :role_description, :rule_id)
    end
end
