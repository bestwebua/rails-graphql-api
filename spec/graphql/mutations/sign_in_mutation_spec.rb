# frozen_string_literal: true

RSpec.describe Mutations::SignInMutation do
  subject(:resolver) { described_class.new(object: nil, context: {}).resolve(**params) }

  let(:user) { create(:user) }
  let(:params) { { email: email } }

  context 'when existing user' do
    let(:email) { user.email }

    it 'returns hash with token and user' do
      expect(resolver).to eq(token: create_access_token(email), user: user)
    end
  end

  context 'when not existing user' do
    let(:email) { 'not_existing@email.com' }

    it 'raises an exception' do
      expect { resolver }.to raise_error(GraphQL::ExecutionError, Mutations::BaseMutation::USER_NOT_FOUND_ERROR)
    end
  end
end
