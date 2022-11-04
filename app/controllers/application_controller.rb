class ApplicationController < ActionController::Base
    include Halt
    include Pagy::Backend
    # Enable all after debug!
    #rescue_from Exception, with: :render_500
    #rescue_from ActiveRecord::RecordNotFound, with: :not_found
    #rescue_from ActionController::RoutingError, with: :not_found
    
    halt I18n::InvalidLocale, with: :not_acceptable
    around_action :switch_locale

    include Authenticatable
    pp "Auth init DONE!"
    pp Rails.configuration.set
    pp "App config DONE!"


    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def require_login
      unless current_user.present? 
        flash[:error] = t('messages.no_admin_access')
        redirect_to root_path # halts request cycle
      end
    end

    def stop_all
        halt :unauthorized
    end
    
    def route_not_found
      respond_to do |format|
        format.html { render file: Rails.public_path.join('404.html'), status: :not_found, layout: false }
        format.json { render nothing: true, status: 404}
      end  
    end
    
    def not_found
      respond_to do |format|
        format.html { render file: Rails.public_path.join('404.html'), status: :unprocessable_entity, layout: false }
        format.json { render nothing: true, status: 404}
      end      
    end
    
    def render_500(error)
      respond_to do |format|
        format.html { render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false }
        format.json { render nothing: true, status: 500}
      end
    end
    
    def is_number?(string)
      true if Float(string)
    rescue StandardError
      false
    end

end
