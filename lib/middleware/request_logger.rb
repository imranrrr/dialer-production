# Add below into config/application.rb:
#
#     config.middleware.use 'RequestLogger'
#

VALID_LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]

class RequestLogger
  def initialize app , log_level
    @log_level = VALID_LOG_LEVELS.include?(log_level) ? log_level : :info
    @app = app
  end

  def call env
    dup._call env
  end


  def _call(env)
    request = ActionDispatch::Request.new env
    started_on = Time.now
    begin
      status, _, _ = response = @app.call(env)
      log(env, status, started_on, Time.now)
    rescue Exception => exception
      status = determine_status_code_from_exception(exception)
      log(env, status, started_on, Time.now, exception)
      raise exception
    end

    response
  end

  def log(env, status, started_on, ended_on, exception = nil)
    ended_on = Time.now
    url = env['REQUEST_URI']
    path = env['PATH_INFO']
    user = try_current_user(env)
    time_spent = ended_on - started_on
    user_agent = env['HTTP_USER_AGENT']
    ip = env['action_dispatch.remote_ip'].calculate_ip
    request_method = env['REQUEST_METHOD']
    http_host = env['HTTP_HOST']

    Rails.logger.send(@log_level, status)
    Rails.logger.send(@log_level, url)
    Rails.logger.send(@log_level, path)
    Rails.logger.send(@log_level, user.inspect)
    Rails.logger.send(@log_level, user.try(:id)) if user
    Rails.logger.send(@log_level, user.group.try(:group)) if user
    Rails.logger.send(@log_level, user.role.try(:role)) if user
    Rails.logger.send(@log_level, user.rank) if user 
    Rails.logger.send(@log_level, time_spent)
    Rails.logger.send(@log_level, user_agent)
    Rails.logger.send(@log_level, ip)
    Rails.logger.send(@log_level, request_method)
    Rails.logger.send(@log_level, http_host)
    Rails.logger.send(@log_level, exception&.class&.name)
    Rails.logger.send(@log_level, exception&.message)
    if user
      Log.create(
        status: status,
        url: url,
        path: path,
        user_inspect: user.inspect,
        user_id: user.id,
        group_id: user.group_id,
        role_id: user.role_id,
        rank: user.rank,
        time_spent: Time.at(time_spent),
        user_agent: user_agent,
        ip: ip,
        request_method: request_method,
        http_host: http_host,
        exception_class: exception&.class&.name,
        exception_message: exception&.message
        )
      else
        Log.create(
        status: status,
        url: url,
        path: path,
        time_spent: Time.at(time_spent),
        user_agent: user_agent,
        ip: ip,
        request_method: request_method,
        http_host: http_host,
        exception_class: exception&.class&.name,
        exception_message: exception&.message
        )
      end


  rescue Exception => exception
    Rails.logger.error(exception.message)
  end

  def determine_status_code_from_exception(exception)
    exception_wrapper = ActionDispatch::ExceptionWrapper.new(nil, exception)
    exception_wrapper.status_code
  rescue
    500
  end

  def try_current_user(env)
    controller = env['action_controller.instance']
    return unless controller.respond_to?(:current_user, true)
    return unless [-1, 0].include?(controller.method(:current_user).arity)
    controller.__send__(:current_user)
  end
end
