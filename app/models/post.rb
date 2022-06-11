class Post < ApplicationRecord
  after_save :update_posts_counter
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :update_posts_counter, ->(user, count) { user.update(posts_counter: count) }
  # scope :last_five_comments, ->(post) { Comment.where(post:).last(5) }
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

  def last_five_comments
    comments.last(5)
  end

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
