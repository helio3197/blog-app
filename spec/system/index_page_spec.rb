require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  it 'I can see the username of all other users.' do
    visit root_path
    expect(page).to have_content('Jhon')
  end

end
