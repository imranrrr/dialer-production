class RulesController < ApplicationController
  before_action :require_login
  before_action :set_rule, only: %i[ show edit update destroy ]

  #TODO all security check!
  # GET /rules or /rules.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_rule' )
    @rules = Rule.all
    @model_name = Rule.model_name.human(count: 2)
  end

  # GET /rules/1 or /rules/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'show_rule' )
    @model_name_single = Rule.model_name.human
  end

  # GET /rules/new
  def new
    stop_all
    halt :unauthorized unless helpers.allowed?(current_user, 'add_rule' )
    @model_name_single = Rule.model_name.human
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_rule' )
    @model_name_single = Rule.model_name.human
  end

  # POST /rules or /rules.json
  def create
    stop_all
#    if helpers.allowed?(current_user, 'add_rule' )  
#      @rule = Rule.new(rule_params)
#      respond_to do |format|
#        if @rule.save
#          format.html { redirect_to @rule, notice: t('messages.rule_created') }
#          format.json { render :show, status: :created, location: @rule }
#        else
#          format.html { render :new, status: :unprocessable_entity }
#          format.json { render json: @rule.errors, status: :unprocessable_entity }
#        end
#      end
#    else
#      halt :unauthorized 
#    end      
  end

  # PATCH/PUT /rules/1 or /rules/1.json
  def update
    if helpers.allowed?(current_user, 'edit_rule' )
      respond_to do |format|
        if @rule.update(rule_params)
          format.html { redirect_to @rule, notice: t('messages.ule_updated') }
          format.json { render :show, status: :ok, location: @rule }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @rule.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized 
    end         
  end

  # DELETE /rules/1 or /rules/1.json
  def destroy
  stop_all
#    if helpers.allowed?(current_user, 'delete_dial_group' )  
#     @rule.destroy
#      respond_to do |format|
#        format.html { redirect_to rules_url, notice: t('messages.rule_deleted') }
#        format.json { head :no_content }
#      end
#    else
#      halt :unauthorized 
#    end      
#
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rule_params
      params.require(:rule).permit(:rule, :rule_description)
    end
end
