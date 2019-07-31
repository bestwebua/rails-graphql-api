# frozen_string_literal: true

module Query
  RSpec.describe 'Items', type: :request do
    let(:post_request) { post '/graphql', params: params }
    let(:params) { { query: query } }
    let(:query) do
      <<~GQL
        query {
          items {
            id
            title
            description
            imageUrl
            user {
              id
              email
              fullName
            }
          }
        }
      GQL
    end

    shared_examples 'renders json' do
      it 'returns json items collection' do
        expect(response).to match_schema(ItemsSchema::Success)
        expect(response).to be_ok
      end
    end

    context 'without items' do
      before { post_request }

      include_examples 'renders json'
    end

    context 'with items' do
      before do
        create_pair(:item, user: create(:user))
        post_request
      end

      include_examples 'renders json'
    end
  end
end
