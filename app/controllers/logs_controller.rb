class LogsController < ApplicationController
  before_action :require_login
  before_action :set_log, only: %i[ show ]
  
  # GET /logs or /logs.json
  def index
    halt :unauthorized unless helpers.allowed?(current_user, 'log_reader' )
    @pagy, @logs = pagy(Log)
  end

  # GET /logs/1 or /logs/1.json
  def show
    halt :unauthorized unless helpers.allowed?(current_user, 'log_reader' )
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.require(:log).permit(:status, :url, :path, :user_inspect, :user_id, :group_id, :role_id, :rank, :time_spent, :user_agent, :ip, :request_method, :http_host, :exception_class, :exception_message)
    end
end
