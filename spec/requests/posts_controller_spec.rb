require 'rails_helper'

describe 'Posts controller tests', type: :request do
  context 'posts#index' do
    before(:example) { get '/users/1/posts' }

    it 'Response status should be 200: ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'It should render the correct template' do
      expect(response).to render_template(:index)
    end

    it 'The response body should contain placeholder text' do
      expect(response.body).to include('Number of posts')
    end
  end

  context 'posts#show' do
    before(:example) { get '/users/1/posts/1' }

    it 'Response status should be 200: ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'It should render the correct template' do
      expect(response).to render_template(:show)
    end

    it 'The response body should contain placeholder text' do
      expect(response.body).to include('Comments:')
    end
  end
end
