class Record < ApplicationRecord
  validates :description, presence: {:message => I18n.t('global.errors.record_presence')}
  validates :description, uniqueness: {:message => I18n.t('global.errors.record_taken')}
  has_many :dials, dependent: :restrict_with_error
end
