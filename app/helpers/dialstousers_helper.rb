module DialstousersHelper

  def allow_user_list(user)
    User.where(group: user.group.descendants) + User.where(group: user.group_id)
  end

  def allow_dials_to_user_list(user)
    users = User.where(group: user.group.descendants) + User.where(group: user.group_id).ids
    Dialstouser.where(user_id: users)
  end  
      
end
