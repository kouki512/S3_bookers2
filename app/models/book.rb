class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments
  has_many :favorites
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  scope :get_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :get_yesterday, -> {where(created_at: Time.zone.now.yesterday)}
  scope :get_week, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope :get_month, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)}
  scope :weekly_sort, -> (to,from){includes(:favorites).where(created_at: from...to).size}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
