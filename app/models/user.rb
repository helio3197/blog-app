class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  scope :last_three_posts, ->(user) { Post.where(author: user).last(3) }
  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  def last_three_posts
    posts.last(3)
  end
end
