class CallSingleUserJob < ApplicationJob
  require 'fsr'
  queue_as :default

  def perform(id, sms_code)
    sip = Rails.configuration.set[:sip]
    FSR.load_all_commands
    sock = FSR::CommandSocket.new(server: sip['fs_server'], port: sip['fs_port'], auth: sip['fs_auth'])
    UserLogin::call_counter(sock, sip, 'single')
    case sms_code
      when ''
        dial = Dial.find(id)
        s = sock.originate(timeout: sip[:timeout], caller_id_number: sip[:caller_id_number], caller_id_name: sip[:caller_id_name],
        target: '{' + 'sound_file_name=' + "#{dial.sound_url}.wav" + ',' + 'dial_id=' + "#{dial.id}" +'}' + "sofia/gateway/#{sip[:gateway]}/#{dial.user.phone.delete_prefix!(sip[:prefix])}",
        endpoint: '9198 XML default').run
      else
        user = User.find(id)
        s = sock.originate(timeout: sip[:timeout], caller_id_number: sip[:caller_id_number], caller_id_name: sip[:caller_id_name],
        target: '{sms_code=' + sms_code + ',' + 'locale=' + I18n.locale.to_s + '}' + "sofia/gateway/#{sip[:gateway]}/#{user.phone.delete_prefix!(sip[:prefix])}",
        endpoint: '9197 XML default').run
      end     
    sock = nil
    rescue => e
      Rails.logger.error e
  end
end
