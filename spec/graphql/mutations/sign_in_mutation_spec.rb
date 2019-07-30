# frozen_string_literal: true

module Mutations
  RSpec.describe SignInMutation, type: :request do
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
        expect(data).to include(
          'token' => Base64.encode64(user.email),
          'user' => { 'id' => user.id.to_s, 'fullName' => "#{user.first_name} #{user.last_name}" }
        )
        expect(response).to be_ok
      end
    end

    describe 'Failure' do
      context 'when not existing user' do
        let(:email) { 'not_user_email@domain.com' }

        it 'renders json with error' do
          # expect(response).to match_schema(SignInSchema::UserNotFound)
          expect(response).to be_ok
        end
      end
    end
  end
end
