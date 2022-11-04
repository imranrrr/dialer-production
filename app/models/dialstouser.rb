class Dialstouser < ApplicationRecord
  belongs_to :user
  belongs_to :dial

  validates :user_id, presence: true
  validates :dial_id, presence: true
  validates :dial_id, uniqueness: { scope: :user_id }
end
