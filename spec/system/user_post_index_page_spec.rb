require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  it 'I can see the user\'s profile picture.' do
    visit user_posts_path(user_id: 1)
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  it 'I can see the user\'s username.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Jhon')
  end

  it 'I can see the number of posts the user has written.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the post title.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Post test')
  end

  it 'I can see some of the post\'s body' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Post test')
  end

  it 'I can see the first comments on a post' do
    Comment.create(author_id: 1, post_id: 1, text: 'This is the test comment')
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('This is the test comment')
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Comments: 0')
  end

  it 'I can see how many Likes a post has.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Likes: 0')
  end

  it "When I click on a post, it redirects me to that post's show page" do
    visit user_posts_path(user_id: 1)
    click_on('Post test')
    expect(page).to have_current_path(user_post_path(user_id: 1, id: 1))
  end
end
