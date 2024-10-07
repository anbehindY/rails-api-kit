require "swagger_helper"

RSpec.describe "Users API", type: :request do
  let(:valid_attributes) { {user: {name: "test user", email: "user@example.com", password: "password123"}} }
  let(:invalid_attributes) { {user: {name: "test user", email: "invalidemail", password: "short"}} }
  let!(:user1) { create(:user, name: "user1", email: "user1@example.com", password: "password") }

  path "/signup" do
    post("User Registration") do
      tags "User"
      consumes "application/json"
      produces "application/json"

      parameter name: :user, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: {type: :string},
              email: {type: :string},
              password: {type: :string}
            },
            required: %w[name email password]
          }
        }
      }

      response(200, "OK") do
        let(:user) { valid_attributes }
        run_test!
      end

      response(422, "unprocessable entity") do
        let(:user) { invalid_attributes }
        run_test!
      end
    end
  end

  path "/login" do
    post("User Login") do
      tags "User"
      consumes "application/json"
      produces "application/json"
      parameter name: :user, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: {type: :string},
              password: {type: :string}
            },
            required: %w[email password]
          }
        }
      }

      response(200, "created") do
        let(:user) { {user: {email: user1.email, password: user1.password}} }
        run_test!
      end

      response(401, "unauthorized") do
        let(:user) { {user: {email: "wrong@example.com", password: "wrongpassword"}} }
        run_test!
      end
    end
  end
end
