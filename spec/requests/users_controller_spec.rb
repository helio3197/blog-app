require 'rails_helper'

describe 'Users controller tests', type: :request do
  context 'users#index' do
    before(:example) { get '/users' }

    it 'Response status should be 200: ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'It should render the correct template' do
      expect(response).to render_template(:index)
    end

    it 'The response body should contain placeholder text' do
      expect(response.body).to include('User name')
    end
  end

  context 'users#show' do
    before(:example) { get '/users/1' }

    it 'Response status should be 200: ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'It should render the correct template' do
      expect(response).to render_template(:show)
    end

    it 'The response body should contain placeholder text' do
      expect(response.body).to include('Bio')
    end
  end
end
