require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(author: User.first, title: 'Test', text: 'RSpec', comments_counter: 0, likes_counter: 0)
  end

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should not be valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid with a title of length more than 250' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without a valid positive comments_counter integer' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without a valid positive likes_counter integer' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'Should have a #last_five_comments method' do
    subject.comments = [Comment.new(text: 'Text', author: User.first, post: subject)]
    expect(subject.last_five_comments).to all(be_an_instance_of(Comment)) && have_attributes(length: (a_value <= 5))
  end

  it 'Should have a #update_posts_counter method' do
    posts_count = subject.author.posts_counter

    expect do
      subject.save
    end
      .to change { subject.author.posts_counter }.from(posts_count).to(posts_count + 1)
  end
end
