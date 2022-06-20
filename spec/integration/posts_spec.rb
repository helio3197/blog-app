require 'swagger_helper'

describe 'Posts API' do
  after(:all) do
    Post.last.destroy
    User.last.destroy
  end

  path '/api/users/{user_id}/posts' do
    get 'Retrieve list of posts for a given user' do
      tags 'Posts'
      security [bearer_auth: []]
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      user = User.create(id: 2, name: 'Jhon API', bio: 'Test user', email: 'test2@test.com', password: 'abc123', confirmed_at: Time.now)
      Post.create(id: 2, author: user, title: 'Post API test', text: 'Testing... api', comments_counter: 0,
                  likes_counter: 0)
      let(:user_id) { user.id }

      response '200', 'name found' do
        let(:Authorization) { "Bearer #{JWT_TOKEN}" }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 }
               },
               required: %w[id title text comments_counter likes_counter]

        run_test!
      end

      response '401', 'unauthorized request' do
        let(:Authorization) { '' }

        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end

      # response '404', 'user not found' do
      #   let(:Authorization) { "Bearer #{JWT_TOKEN}" }
      #   let(:user_id) { 9 }

      #   schema type: :object,
      #          properties: {
      #            error: { type: :string }
      #          },
      #          required: %w[error]

      #   run_test!
      # end
    end
  end
end
