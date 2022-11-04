class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_vars

  def set_vars
    @ranks = Rails.configuration.set[:ranks]
    @default_rank = Rails.configuration.set[:default_rank]  
    @groups = helpers.user_groups(current_user)
    @roles = Role.all.pluck(:role)
  end

  # GET /users or /users.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'show_user' )
    @pagy, @users = pagy(User.allow_user_list(current_user))
    # moved to User.rb model instead helper
    # @users = helpers.allow_user_list(current_user)
    @model_name = User.model_name.human(count: 2)
  end

  # GET /users/1 or /users/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'show_user' ) && helpers.allow_show_user(current_user).include?(params[:id].to_i)
    @model_name_single = User.model_name.human
  end

  # GET /users/new
  def new
      halt :unauthorized unless helpers.allowed?(current_user, 'add_user' ) 
      @model_name_single = User.model_name.human
      @user = User.new  
  end

  # GET /users/1/edit
  def edit
    halt :unauthorized unless helpers.allowed?(current_user, 'edit_user' ) && helpers.allow_edit_user(current_user).include?(params[:id].to_i)
    @model_name_single = User.model_name.human
  end

  # POST /users or /users.json
  def create
    if helpers.allowed?(current_user, 'add_user' )
      u_p = user_params.dup
      u_p[:role] = Role.find_by(:role => user_params[:role])
      u_p[:group] = Group.find_by(:group => user_params[:group])
      u_p[:phone1] = u_p[:phone] if u_p[:phone1] == ''
      u_p[:phone2] = u_p[:phone] if u_p[:phone2] == ''
      pp u_p
      @user = User.new(u_p)
      
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: t('messages.user_created')}
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
       halt :unauthorized 
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if helpers.allowed?(current_user, 'edit_user' )
        u_p = user_params.dup
        u_p[:role] = Role.find_by(:role => user_params[:role])
        u_p[:group] = Group.find_by(:group => user_params[:group])
        
        respond_to do |format|
        if @user.update(u_p)
          format.html { redirect_to @user, notice: t('messages.user_updated') }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      halt :unauthorized
    end
  end

  # DELETE /users/1 or /users/1.json
  # DISABLED AT ALL!!!

# Don't delete users at all because logs will broken!
# No rules for user destroy exist!

  def destroy
    stop_all
    #@user.destroy
      #respond_to do |format|
        #format.html { redirect_to users_url, notice: t('messages.user_deleted') }
        #format.json { head :no_content}
      #end
  end

  def search
    halt :unauthorized unless helpers.allowed?(current_user, 'show_user')
    @pagy, @users = pagy(User.search_in_all_fields("#{params[:search]}").allow_user_list(current_user), items: Rails.configuration.set[:dials_per_page]*100) if params[:search]
    @model_name = User.model_name.human(count: 2)
    render :index
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
    pin_code_length = Rails.configuration.set[:pin_code_length]
    if !params[:search]
      if params[:user][:pincode] == '1'
        params[:user][:pincode] = pin_code_length.times.map{rand(10)}.join
      else
        if @user
          params[:user][:pincode] = @user.pincode
        else
          params[:user][:pincode] = pin_code_length.times.map{rand(10)}.join
        end
      end 
      params.require(:user).permit(:phone, :phone1, :phone2, :fio, :rank, :role, :group, :pincode, :active, :search)
    end

  end
end
