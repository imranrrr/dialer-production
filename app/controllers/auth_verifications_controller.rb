# app/controllers/auth_verifications_controller.rb
class AuthVerificationsController < ApplicationController
  skip_before_action :authenticate_user!, :raise => false

  def show
    @phone = session[:phone]
    render "auth/verify"
  end

  def create
    @phone = session[:phone]
    resp = UserLogin.verify(@phone, params[:auth_code], session[:salt])

    if resp.error
      flash[:error] = resp.error
      render "auth/verify"
    else
      session.delete(:phone)
      session.delete(:salt)
      session[:user_id] = resp.user.id
      redirect_to root_path, notice: t('messages.you_signed_in')
    end
  end
end
