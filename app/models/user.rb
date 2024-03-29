class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  scope :last_three_posts, ->(user) { Post.where(author: user).last(3) }
  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  def last_three_posts
    posts.last(3)
  end

  private

  def set_defaults
    self.posts_counter ||= 0
  end
end
