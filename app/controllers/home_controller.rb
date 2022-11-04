class HomeController < ApplicationController

  def index
    current_user.present?
  end

end
