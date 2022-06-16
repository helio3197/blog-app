require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  it 'I can see the username of all other users.' do
    visit root_path
    expect(page).to have_content('Jhon')
  end

  it 'I can see the profile picture for each user.' do
    visit root_path
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  
end
