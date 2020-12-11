class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  # default_scope { where(deleted_at: nil) }

  # def destroy
  #   update(deleted_at: Time.now)
  # end
end
