class Board < ApplicationRecord
  
  validates :title, presence: true, length: { minimum: 4 }

  has_many :posts

  def owned_by?(user)
    self.user == user
  end
end
