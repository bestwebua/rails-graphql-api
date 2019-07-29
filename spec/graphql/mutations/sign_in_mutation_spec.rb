# frozen_string_literal: true

module Mutations
  RSpec.describe SignInMutation, type: :request do
    describe '#resolve' do
      let(:user) { create(:user) }
      let(:variables) { { email: user.email } }
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

      specify do
        post '/graphql', params: { query: mutation, variables: variables }
        json = JSON.parse(response.body)
        data = json['data']['signIn']

        expect(data).to include(
          'token' => Base64.encode64(user.email),
          'user' => { 'id' => user.id.to_s, 'fullName' => "#{user.first_name} #{user.last_name}" }
        )
      end
    end
  end
end
