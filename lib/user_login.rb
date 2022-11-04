module UserLogin
  module_function
  # Called when a user first types their phone address
  # requesting to login or sign up.
  require 'fsr'

  def call_counter(sock, sip, type)   
    loop do
      call_count = sock.calls.run.length 
      case type
      when 'many'
        break if call_count < sip[:max_calls] - sip[:reserve_calls]        
      when 'single'
        break if call_count < sip[:max_calls]  
      end        
      Rails.logger.warn 'Calls count: ' + call_count.to_s + ' Call limit: ' + sip[:max_calls].to_s + ' So calls will be delayed for: ' + sip[:call_delay].to_s + ' Seconds'       
      sleep sip[:call_delay]      
    end  
  rescue => e
    Rails.logger.error  e     
  end

  def start_auth(params)
    # Generate the salt for this login, it will later 
    # be stored in rails session.
    salt = User.generate_auth_salt
    user = User.find_by(phone: params.fetch(:phone).downcase.strip)
    if user.nil?
      # User is registering a new account
      params.merge!(group: Group.second, role: Role.first, phone1: params[:phone], phone2: params[:phone])
      user = User.create!(params)
    end

    # phone the user their 6 digit code
    # AuthMailer.auth_code(user, user.auth_code(salt)).deliver_now
    sms_code = user.auth_code(salt)
#    `ssh pi@192.168.1.10 -i /home/michael/.ssh/id_smssend /home/pi/app/smssend.rb "#{user.phone} #{sms_code}" "Code"`
    p sms_code
    CallSingleUserJob.perform_later(user.id, sms_code)
    salt
  end

  # Called to check the code the user types
  # in and make sure it’s valid.
  def verify(phone, auth_code, salt)
    user = User.find_by(phone: phone)

    if user.blank?
      return UserLoginResponse.new(I18n.t 'messages.phone_not_found')
    end

    unless user.valid_auth_code?(salt, auth_code)
      return UserLoginResponse.new(I18n.t 'messages.invalid_code')
    end

    UserLoginResponse.new(nil, user)
  end

  UserLoginResponse = Struct.new(:error, :user)
end
