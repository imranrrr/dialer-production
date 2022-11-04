module GroupsHelper

  def groups(user)
    user.group.descendants.pluck(:group)  + user.group.group.split('\n')
  end

  # Moved to group model function 
  #def allow_group_list(user)
    #user.group.descendants + Group.where(id: user.group.id)
  #end

  def allow_show_group(user)
    user.group.descendants.ids + user.group_id.to_s.split.map(&:to_i)
  end
        
  def allow_edit_group(user)
    allow_show_group(user)
  end  
  
end
