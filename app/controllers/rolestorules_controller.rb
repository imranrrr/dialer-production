class RolestorulesController < ApplicationController
  before_action :stop_all
  before_action :require_login
  before_action :set_rolestorule, only: %i[ show edit update destroy ]
  before_action :set_vars

  def set_vars
    @roles = Role.all.pluck(:role_description)
    @rules = Rule.all.pluck(:rule_description)
  end

  # GET /rolestorules or /rolestorules.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_role_to_rule' )
    @rolestorules = Rolestorule.all
    @model_name = Rolestorule.model_name.human(count: 2)
  end

  # GET /rolestorules/1 or /rolestorules/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'show_role_to_rule' )
    @model_name_single = Rolestorule.model_name.human
  end

  # GET /rolestorules/new
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_role_to_rule' ) 
    @model_name_single = Rolestorule.model_name.human
    @rolestorule = Rolestorule.new
  end

  # GET /rolestorules/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_role_to_rule' )
    @model_name_single = Rolestorule.model_name.human
  end

  # POST /rolestorules or /rolestorules.json
  def create
    if helpers.allowed?(current_user, 'add_role_to_rule' )
      r_r = rolestorule_params.dup
      r_r[:role] = Role.find_by(:role_description => rolestorule_params[:role])
      r_r[:rule] = Rule.find_by(:rule_description => rolestorule_params[:rule])
      @rolestorule = Rolestorule.new(r_r)
      respond_to do |format|
        if @rolestorule.save
          format.html { redirect_to @rolestorule, notice: "Rolestorule was successfully created." }
          format.json { render :show, status: :created, location: @rolestorule }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @rolestorule.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end
  end

  # PATCH/PUT /rolestorules/1 or /rolestorules/1.json
  def update
    if helpers.allowed?(current_user, 'edit_role_to_rule' ) 
      r_r = rolestorule_params.dup
      r_r[:role] = Role.find_by(:role_description => rolestorule_params[:role])
      r_r[:rule] = Rule.find_by(:rule_description => rolestorule_params[:rule])
      respond_to do |format|
        if @rolestorule.update(r_r)
          format.html { redirect_to @rolestorule, notice: "Rolestorule was successfully updated." }
          format.json { render :show, status: :ok, location: @rolestorule }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @rolestorule.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end 
  end

  # DELETE /rolestorules/1 or /rolestorules/1.json
  def destroy
     if helpers.allowed?(current_user, 'delete_role_to_rule' )
      @rolestorule.destroy
      respond_to do |format|
        format.html { redirect_to rolestorules_url, notice: "Rolestorule was successfully destroyed." }
        format.json { head :no_content }
     end
    else
      halt :unauthorized 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rolestorule
      @rolestorule = Rolestorule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rolestorule_params
      params.require(:rolestorule).permit(:role, :rule)
    end
end
