class Group < ApplicationRecord
  has_ancestry
  has_many :users, dependent: :restrict_with_error

  has_many :dialstogroups, dependent: :restrict_with_error
  has_many :dials, through: :dialstogroups, dependent: :restrict_with_error

  validates :group, uniqueness: {:message => I18n.t('global.errors.group_taken')}
  validates :group, :group_description, presence: {:message => I18n.t('global.errors.shold_be_filled')}

  scope :search_in_all_fields, ->(text){
    where(
      column_names
      .map {|field| "groups.#{field} like '%#{text}%'"}
      .join (" or ")
    )
  }
  
  def self.allow_group_list(user)
    Group.where(id: user.group.descendants.ids).or(Group.where(id: user.group.id)).order(id: :desc)
  end
  
  def self.dial_groups(user)
    Group.where(id: user.group.descendants.joins(:users).ids).or(Group.where(id: user.group.id)).order(id: :desc)
  end  
  
end
