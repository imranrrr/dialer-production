module ApplicationHelper
  include Pagy::Frontend
  
  def allowed?(user, rule)
    allowed = []
    user.role.rules.each {|r| allowed << r.rule}
    allowed.include?(rule) # ? true : false
  end

  def format_time(time)
    time.in_time_zone('Asia/Tashkent')
  end

end
