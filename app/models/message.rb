class Message < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user, dependent: :destroy
end
