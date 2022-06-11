require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new(author: User.first, post: Post.first, text: 'Testing') }

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should have a #update_comments_counter method' do
    comments_count = subject.post.comments_counter

    expect do
      subject.save
    end
      .to change { subject.post.comments_counter }.from(comments_count).to(comments_count + 1)
  end
end
