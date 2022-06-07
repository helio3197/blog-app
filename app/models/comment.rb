class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  scope :update_comments_counter, ->(post, count) { post.update(comments_counter: count) }
end
