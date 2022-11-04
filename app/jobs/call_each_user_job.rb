class CallEachUserJob < ApplicationJob
  require 'fsr'
  queue_as :default

  def get_pincode(amaflags)
    ActiveRecord::Base.connection_pool.with_connection do
      cdr = Cdr.find_by_amaflags(amaflags) 
      if cdr 
         pincode = cdr.userfield
      else
         pincode = ''   
      end   
    end
  end

  def perform(user)
    sleep Rails.configuration.set[:delay_between_mass_calls]
    Rails.logger.warn 'Run calls from user:' + user.inspect
    dial = Dial.find(user[:dial])
    if dial.record
      sound_file = dial.record.sound_url
    else
      sound_file = user[:sound_url]
    end
    amaflags = SecureRandom.uuid
    sip = Rails.configuration.set[:sip]
    FSR.load_all_commands
    sock = FSR::CommandSocket.new(server: sip[:fs_server], port: sip[:fs_port], auth: sip[:fs_auth])
    [user[:phone], user[:phone1], user[:phone2]].each do |phone|
      UserLogin::call_counter(sock, sip, 'many')
      s = sock.originate(timeout: sip[:timeout], caller_id_number: sip[:caller_id_number], caller_id_name: sip[:caller_id_name],
      target: '{' + 'sound_file_name=' + "#{sound_file}.wav" + ',' + 'accountcode=' + "#{user[:accountcode]}" + ','+ 'amaflags=' + amaflags +'}' + "sofia/gateway/#{sip[:gateway]}/#{phone.delete_prefix!(sip[:prefix])}",
      endpoint: '9196 XML default').run
      Rails.logger.warn 'Responce:' + s.inspect
      sleep sip[:cdr_timer]
      break if get_pincode(amaflags) == user[:pincode]
      end
  rescue => e
    Rails.logger.error  e  
  ensure
     sock = nil
  end        
end
