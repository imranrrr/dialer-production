class DialstousersController < ApplicationController

  before_action :stop_all
  before_action :require_login
  before_action :set_dialstouser, only: %i[ show edit update destroy ]
  before_action :set_vars
  
  def set_vars
    @groups = helpers.user_groups(current_user)
    @dials = current_user.dials.pluck(:description)
  end
  
  # GET /dialstousers or /dialstousers.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_dial_user' )
    @dialstousers = helpers.allow_dials_to_user_list(current_user)
    @model_name = Dialstouser.model_name.human(count: 2)
  end

  # GET /dialstousers/1 or /dialstousers/1.json
  def show
    halt :unauthorized until helpers.allowed?(current_user, 'show_dial_user' )
    @model_name_single = Dialstouser.model_name.human
  end

  # GET /dialstousers/new
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_dial_user' ) 
    @model_name_single = Dialstouser.model_name.human
    @dialstouser = Dialstouser.new
  end

  # GET /dialstousers/1/edit
  def edit
  end

  # POST /dialstousers or /dialstousers.json
  def create
    @dialstouser = Dialstouser.new(dialstouser_params)

    respond_to do |format|
      if @dialstouser.save
        format.html { redirect_to @dialstouser, notice: "Dialstouser was successfully created." }
        format.json { render :show, status: :created, location: @dialstouser }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dialstouser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dialstousers/1 or /dialstousers/1.json
  def update
    respond_to do |format|
      if @dialstouser.update(dialstouser_params)
        format.html { redirect_to @dialstouser, notice: "Dialstouser was successfully updated." }
        format.json { render :show, status: :ok, location: @dialstouser }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dialstouser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialstousers/1 or /dialstousers/1.json
  def destroy
    @dialstouser.destroy
    respond_to do |format|
      format.html { redirect_to dialstousers_url, notice: "Dialstouser was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialstouser
      @dialstouser = Dialstouser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dialstouser_params
      params.require(:dialstouser).permit(:user_id, :dial_id)
    end
        
end
