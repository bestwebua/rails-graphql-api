# frozen_string_literal: true

module Mutation
  RSpec.describe 'AddItem', type: :request do
    let(:user) { create(:user) }
    let(:token) { create_access_token(user.email) }
    let(:title) { FFaker::Book.title }
    let(:description) { FFaker::Book.description }
    let(:image_url) { FFaker::Book.cover }
    let(:variables) { { title: title, description: description, imageUrl: image_url } }
    let(:params) { { query: mutation, variables: variables } }
    let(:mutation) do
      <<~GQL
        mutation ($title: String!, $description: String, $imageUrl: String) {
          addItem(title: $title, description: $description, imageUrl: $imageUrl) {
            item {
              id
              title
              description
              imageUrl
              user {
                id
              }
            }
            errors
          }
        }
      GQL
    end

    before { post '/graphql', headers: headers, params: params }

    describe 'Success' do
      let(:headers) { { Authorization: token } }

      it 'renders json with new item' do
        expect(response).to match_schema(AddItemSchema::Success)
        expect(response).to be_ok
      end
    end

    describe 'Failure' do
      context 'when not authorized' do
        let(:headers) { {} }

        it 'renders json with error' do
          expect(response).to match_schema(AddItemSchema::NotAuthorized)
          expect(response).to be_ok
        end
      end

      context 'when invalid value' do
        let(:headers) { {} }
        let(:title) { nil }

        it 'renders json with error' do
          expect(response).to match_schema(AddItemSchema::InvalidParams)
          expect(response).to be_ok
        end
      end
    end
  end
end
