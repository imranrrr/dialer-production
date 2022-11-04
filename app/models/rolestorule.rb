class Rolestorule < ApplicationRecord
  belongs_to :role
  belongs_to :rule

  validates :role_id, presence: true
  validates :rule_id, presence: true
  validates :rule_id, uniqueness: { scope: :role_id }
  
  scope :selected, ->(role_id, rule_id) { where(role_id: role_id, rule_id: rule_id) }
end
