# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  before_action :set_vars
  skip_before_action :authenticate_user!, except: :destroy, :raise => false

  def show

  end

  def set_vars
    @ranks = Rails.configuration.set[:ranks]
    @default_rank = Rails.configuration.set[:default_rank]
  end

  def create
    session[:phone] = params[:phone]
    session[:salt] = UserLogin.start_auth(params.permit(:phone, :fio, :rank))
    flash[:error] = nil
    redirect_to auth_verifications_path
  rescue ActiveRecord::RecordInvalid => e
    # If the user creations fails (usually when first and last name are empty)
    # we reload the form, and also display the first and last name fields.
    @display_name_fields = true
    flash[:error] = e
    render :show
  end

  def destroy
    session.delete(:user_id)
#    redirect_to auth_path, notice: t('messages.you_signed_out')
    redirect_to root_path, notice: t('messages.you_signed_out')
  end

end
