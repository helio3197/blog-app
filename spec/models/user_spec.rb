require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'Jhon', photo: 'https://example.com', bio: 'Example', email: 'test123@test.com', password: 'abc123') }

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should not be valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without a valid positive posts_counter integer' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'Should have a #last_three_posts method' do
    subject.posts = [Post.new(title: 'Test', text: 'Post', author: subject)]
    expect(subject.last_three_posts).to all(be_an_instance_of(Post)) && have_attributes(length: (a_value <= 3))
  end
end
