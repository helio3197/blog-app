class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  scope :update_posts_counter, ->(user, count) { user.update(posts_counter: count) }
end
