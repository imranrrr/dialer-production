class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :rolestorules, dependent: :restrict_with_error
  has_many :rules, through: :rolestorules, dependent: :restrict_with_error
  validates :role, uniqueness: {:message => I18n.t('global.errors.role_taken')}
end
