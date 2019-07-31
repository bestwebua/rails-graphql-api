# frozen_string_literal: true

module Mutation
  RSpec.describe 'SignIn', type: :request do
    let(:variables) { { email: email } }
    let(:data) { JSON.parse(response.body)['data']['signIn'] }
    let(:mutation) do
      <<~GQL
        mutation($email: String!) {
          signIn(email: $email) {
            token
            user {
              id
              fullName
            }
          }
        }
      GQL
    end

    before { post '/graphql', params: { query: mutation, variables: variables } }

    describe 'Success' do
      let(:user) { create(:user) }
      let(:email) { user.email }

      it 'renders json with token, user data' do
        expect(response).to match_schema(SignInSchema::Success)
        expect(response).to be_ok
      end
    end

    describe 'Failure' do
      context 'when not existing user' do
        let(:email) { 'not_user_email@domain.com' }

        it 'renders json with error' do
          expect(response).to match_schema(SignInSchema::UserNotFound)
          expect(response).to be_ok
        end
      end

      context 'when invalid email value' do
        let(:variables) { {} }

        it 'renders json with error' do
          expect(response).to match_schema(SignInSchema::InvalidParams)
          expect(response).to be_ok
        end
      end
    end
  end
end
