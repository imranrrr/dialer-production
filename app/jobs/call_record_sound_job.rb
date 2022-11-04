class CallRecordSoundJob < ApplicationJob
  require 'fsr'
  queue_as :default

  def perform(record_id,user_id)
    sip = Rails.configuration.set[:sip]
    FSR.load_all_commands
    sock = FSR::CommandSocket.new(server: sip['fs_server'], port: sip['fs_port'], auth: sip['fs_auth'])
    UserLogin::call_counter(sock, sip, 'single')
      record = Record.find(record_id)
      user = User.find(user_id)
      s = sock.originate(timeout: sip[:timeout], caller_id_number: sip[:caller_id_number], caller_id_name: sip[:caller_id_name],
      target: '{' + 'sound_file_name=' + "#{record.sound_url}.wav" +'}' + "sofia/gateway/#{sip[:gateway]}/#{user.phone.delete_prefix!(sip[:prefix])}",
      endpoint: '9198 XML default').run
    sock = nil
    rescue => e
      Rails.logger.error e
  end
end
