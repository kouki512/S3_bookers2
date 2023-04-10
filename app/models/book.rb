class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments
  has_many :favorites
  # 閲覧数
  has_many :view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :weekly_sort, -> (to,from){includes(:favorites).where(created_at: from...to).size}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def book_view_count(user)
      ViewCount.create(user_id: user.id, book_id: self.id)
  end

end
