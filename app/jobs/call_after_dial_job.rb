class CallAfterDialJob < ApplicationJob
  require 'fsr'
  queue_as :default

  def perform(dial_id, phone)
    sleep sip = Rails.configuration.set[:call_after_dial_timer]
    sip = Rails.configuration.set[:sip]
    FSR.load_all_commands
    sock = FSR::CommandSocket.new(server: sip['fs_server'], port: sip['fs_port'], auth: sip['fs_auth'])
    UserLogin::call_counter(sock, sip, 'single')
        s = sock.originate(timeout: sip[:timeout], caller_id_number: sip[:caller_id_number], caller_id_name: sip[:caller_id_name],
        target: '{dial_id=' + dial_id.to_s + ',' + 'locale=' + I18n.locale.to_s + '}' + "sofia/gateway/#{sip[:gateway]}/#{phone.delete_prefix!(sip[:prefix])}",
        endpoint: '9195 XML default').run
    sock = nil
    rescue => e
      Rails.logger.error e
  end
end
