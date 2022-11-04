class Rule < ApplicationRecord
  has_many :rolestorules, dependent: :restrict_with_error
  has_many :roles, through: :rolestorules, dependent: :restrict_with_error
  validates :rule, uniqueness: {:message => I18n.t('global.errors.role_taken')}
end
