require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { described_class.new(author: User.first, post: Post.first) }

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should have a #update_likes_counter method' do
    likes_count = subject.post.likes_counter

    expect do
      subject.save
    end
      .to change { subject.post.likes_counter }.from(likes_count).to(likes_count + 1)
  end
end
