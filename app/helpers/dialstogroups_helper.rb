module DialstogroupsHelper
  
  def allow_group_list(user)
    user.group.descendants + user.group.split('\n')
   end  
  
  def allow_dials_to_group_list(user)
    Dialstogroup.where(group_id: user.group.descendant_ids)  + user.group.dialstogroups
  end  
  
end
