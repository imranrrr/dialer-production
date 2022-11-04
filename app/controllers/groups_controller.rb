class GroupsController < ApplicationController
  before_action :require_login
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_vars

  def set_vars
    @groups = helpers.groups(current_user)
  end

  # GET /groups or /groups.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_group' )
    if helpers.allowed?(current_user, 'show_group' )
      @pagy, @groups = pagy(Group.allow_group_list(current_user))
      # moved to Group.rb model instead helper
      # @groups = helpers.allow_group_list(current_user).sort
      @index_allowed = true if @groups.any?
      @model_name = Group.model_name.human(count: 2)
    end
  end

  # GET /groups/1 or /groups/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'show_group' ) && helpers.allow_show_group(current_user).include?(params[:id].to_i)
    @model_name_single = Group.model_name.human
  end

  # GET /groups/new
  def new
    halt :unauthorized unless helpers.allowed?(current_user, 'add_group' )
    @model_name_single = Group.model_name.human
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_group' ) && helpers.allow_edit_group(current_user).include?(params[:id].to_i)
    @model_name_single = Group.model_name.human
  end

  # POST /groups or /groups.json
  def create
    if helpers.allowed?(current_user, 'add_group' )
        g_p = group_params.dup.to_h
        p '**********' , group_params[:parent]
        g_p[:parent] = Group.find_by(:group => group_params[:parent])
        p '!!!!!!!!!!!!!!!!!' , g_p.inspect
      @group = Group.new(g_p)
      respond_to do |format|
        if @group.save
          format.html { redirect_to @group, notice: t('messages.group_created') }
          format.json { render :show, status: :created, location: @group }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    if helpers.allowed?(current_user, 'edit_group' )
      respond_to do |format|
        g_p = group_params.dup
        g_p[:parent] = Group.find_by(:group => group_params[:parent])
        if @group.update(g_p)
          format.html { redirect_to @group, notice: t('messages.group_updated') }
          format.json { render :show, status: :ok, location: @group }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    if helpers.allowed?(current_user, 'delete_group' )
      if @group.destroy
          respond_to do |format|
            format.html { redirect_to groups_url, notice: t('messages.group_deleted') }
            format.json { head :no_content }
        end
      else
        redirect_to groups_url, notice: t('messages.group_not_deleted')
      end
    else
      halt :unauthorized
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      #params.fetch(:group, {}) # CHECK IT!!!
      params.require(:group).permit(:group, :group_description, :parent)
    end

end
