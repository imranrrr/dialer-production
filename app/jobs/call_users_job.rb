class CallUsersJob < ApplicationJob
  queue_as :default

  def user_to_hash(user, dial)
      user_hash = {phone: user.phone, 
      phone1: user.phone1, 
      phone2: user.phone2,
      pincode: user.pincode, 
      dial: dial.id,
      sound_url: dial.sound_url,
      accountcode: dial.id
      }      
  end

  def perform(dial)
  
    users = {} 
    dial = Dial.find(dial)
    Rails.logger.warn 'Run calls from dial: ' + dial.inspect
    
    dial.users.each do |user|
      users[user] = dial
      # ENABLE AFTER DEBUG!!!!
      Dialstouser.find_by_user_id_and_dial_id(user.id, dial).update(dialed: true)
    end
  
    dial.groups.each do |group|
       group.users.each do |user|
        users[user] = dial
      end
      # ENABLE AFTER DEBUG!!!!
      Dialstogroup.find_by_group_id_and_dial_id(group.id, dial).update(dialed: true)
    end    
    # ENABLE AFTER DEBUG!!!!
    dial.update(dialed: true)


  users.compact.uniq.each do |user,dial|
    p '******************************'
    pp user_to_hash(user, dial)
    CallEachUserJob.perform_later user_to_hash(user, dial)
    sleep 1
  end
    Rails.logger.warn 'Calls finised for dial: ' + dial.inspect
  rescue => e
     Rails.logger.error  e    
  end
end
