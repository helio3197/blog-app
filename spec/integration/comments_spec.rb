require 'swagger_helper'

describe 'Comments API' do
  before(:all) do
    unless User.find_by(id: 2)
      @user = User.create(id: 2, name: 'Jhon API', bio: 'Test user', email: 'test2@test.com', password: 'abc123',
                          confirmed_at: Time.now)
      @post = Post.create(id: 2, author: @user, title: 'Post API test', text: 'Testing... api', comments_counter: 0,
                          likes_counter: 0)
      Comment.create(author: @user, post: @post, text: 'Testing comment')
    end
  end

  after(:all) do
    Comment.last.destroy
    Post.last.destroy
    User.last.destroy
  end

  path '/api/users/{user_id}/posts/{post_id}/comments' do
    # user = User.create(id: 2, name: 'Jhon API', bio: 'Test user', email: 'test2@test.com', password: 'abc123', confirmed_at: Time.now)
    # post = Post.create(id: 2, author: user, title: 'Post API test', text: 'Testing... api', comments_counter: 0,
    #                    likes_counter: 0)
    # Comment.create(author: user, post:, text: 'Testing comment')

    get 'Retrieve list of comments for a given post' do
      tags 'Comments'
      security [bearer_auth: []]
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      let(:user_id) { @user.id }
      let(:post_id) { @post.id }

      response '200', 'name found' do
        let(:Authorization) { "Bearer #{JWT_TOKEN}" }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   text: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 }
               },
               required: %w[id text author_id post_id]

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
    end

    post 'Create a new comment for a given post' do
      tags 'Comments'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text]
      }

      let(:user_id) { @user.id }
      let(:post_id) { @post.id }

      response '201', 'comment created' do
        let(:Authorization) { "Bearer #{JWT_TOKEN}" }
        let(:comment) { { text: 'New comment...' } }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 post_id: { type: :integer },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id text author_id post_id]

        run_test!
      end

      response '302', 'user not signed-in, redirecting to sign_in route' do
        let(:Authorization) { '' }
        let(:comment) { { text: 'New comment...' } }

        schema type: :string

        run_test!
      end
    end
  end
end
