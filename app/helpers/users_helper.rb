module UsersHelper
# Don't forget to Check abot root users!

    def user_groups(user)
      user.group.descendants.pluck(:group) + user.group.group.split('\n')
    end
    
    #Moved to user.rb model function
    #def allow_user_list(user)
        #User.where(group: user.group.descendants) + User.where(group: user.group_id)
    #end

    def allow_show_user(user)
      groups_for_show = user.group.descendants + user.group_id.to_s.split.map(&:to_i)
      users_for_show = User.where(group: groups_for_show).ids
    end
    
    def allow_edit_user(user)
      allow_show_user(user)
    end
 
end
