require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:all) do
    Comment.create(author_id: 1, post_id: 1, text: 'This is the test comment')
  end

  it 'I can see the post\'s title.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Post test')
  end

  it 'I can see who wrote the post.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('by Jhon')
  end

  it 'I can see how many comments it has.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Comments: 1')
  end

  it 'I can see how many likes it has.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Likes: 0')
  end

  it 'I can see the post body.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Testing...')
  end

  it 'I can see the username of each commentor.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Jhon:')
  end

  it 'I can see the comment each commentor left.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Jhon:')
  end
end
