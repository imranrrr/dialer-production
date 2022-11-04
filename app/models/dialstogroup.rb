class Dialstogroup < ApplicationRecord
  belongs_to :group
  belongs_to :dial

  validates :group_id, presence: true
  validates :dial_id, presence: true
  validates :dial_id, uniqueness: { scope: :group_id }
  
end
