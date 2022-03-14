class Session < ApplicationRecord
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true

  belongs_to :user, 
    foreign_key: :user_id,
    class_name: :User


end
