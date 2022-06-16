require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  it 'I can see the user\'s profile picture.' do
    visit user_path(id: 1)
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  it 'I can see the user\'s username.' do
    visit user_path(id: 1)
    expect(page).to have_content('Jhon')
  end

  it 'I can see the number of posts the user has written.' do
    visit user_path(id: 1)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user\'s bio.' do
    visit user_path(id: 1)
    expect(page).to have_content('Test user')
  end

  it 'I can see the user\'s first 3 posts.' do
    visit user_path(id: 1)
    expect(page).to have_content('Post test')
  end

  it "I can see a button that lets me view all of a user's posts." do
    visit user_path(id: 1)
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    visit user_posts_path(user_id: 1)
    click_on('Post test')
    expect(page).to have_current_path(user_post_path(user_id: 1, id: 1))
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    visit user_path(id: 1)
    click_on('See all posts')
    expect(page).to have_current_path(user_posts_path(user_id: 1))
  end
end
