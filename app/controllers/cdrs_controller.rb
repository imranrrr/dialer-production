class CdrsController < ApplicationController
  before_action :require_login
  before_action :set_cdr, only: %i[ show ]
  
  # GET /cdrs or /cdrs.json
  def index
    if helpers.allowed?(current_user, 'cdr_reader' )
      @pagy, @cdrs = pagy(Cdr)
      @model_name = Cdr.model_name.human(count: 2)
    else
      halt :unauthorized 
    end
  end

  def show
    halt :unauthorized until helpers.allowed?(current_user, 'cdr_reader' )
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdr
      @cdr = Cdr.find(params[:id])
    end

        # Only allow a list of trusted parameters through.
    def log_params
      params.require(:cdr).permit(:calldate, :clid, :src, :dst, :dcontext, :channel, :dstchannel, :lastapp, :lastdata, :duration, :billsec, :start, :answer, :end, :disposition, :amaflags, :accountcode, :userfield, :uniqueid)
    end

end
