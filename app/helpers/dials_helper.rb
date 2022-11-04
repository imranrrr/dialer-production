module DialsHelper
  #def allow_dial_list(user)
    # ToDo FIX it! Dials should be returned searched by current_user.
    #selected_users_ids = User.where(group: user.group.descendants).ids + User.where(group: user.group).ids
    #Dial.where(user_id: selected_users_ids).order(id: :desc)
  #end

  # Moved to group model function 
  #def dial_groups(user)
    #user.group.descendants.joins(:users).uniq + Group.where(id: user.group.id)
  #end

  def find_cdr_by_phone_and_dial_id(phone, dial_id, pincode)
    conf = Rails.configuration.set[:sip]
    str = conf[:cdr_prefix] + phone.delete_prefix!(conf[:prefix])
    if pincode == ''
      Cdr.where(channel: str, accountcode: dial_id.to_s)
    else
      Cdr.find_by_channel_and_accountcode_and_userfield(str, dial_id, pincode)
    end
  rescue
  end

end