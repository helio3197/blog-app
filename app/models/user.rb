class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  scope :last_three_posts, ->(user) { Post.where(author: user).last(3) }
end
