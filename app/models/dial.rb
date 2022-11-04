class Dial < ApplicationRecord
  has_many :dialstousers, dependent: :restrict_with_error
  has_many :dialstogroups, dependent: :restrict_with_error
  has_many :users, through: :dialstousers, dependent: :restrict_with_error
  has_many :groups, through: :dialstogroups, dependent: :restrict_with_error
  belongs_to :user
  belongs_to :record, optional: true

  validates :sound_url, presence: {:message => I18n.t('global.errors.dial_sound_url_presence')}
  validates :description, presence: {:message => I18n.t('global.errors.dial_description_presence')}
  validates :sound_url, uniqueness: {:message => I18n.t('global.errors.dial_sound_url_taken')}
  validates :description, uniqueness: {:message => I18n.t('global.errors.dial_description_taken')}
  
  scope :dialed, ->{ where(dialed: true) }
  scope :date_by_create, ->(date) { where(created_at: date) }
  scope :date_by_update, ->(date) { where(updated_at: date) }

  def self.allow_dial_list(user)
    selected_users_ids = User.where(group: user.group.descendants).or(User.where(group: user.group)).ids
    Dial.where(user_id: selected_users_ids).order(id: :desc)
  end
end
