class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  scope :weekly_sort, -> (to,from){where(created_at: from...to).size}
end
