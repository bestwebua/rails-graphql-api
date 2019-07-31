# frozen_string_literal: true

module Mutation
  RSpec.describe 'UpdateItem', type: :request do
    let(:user) { create(:user) }
    let(:token) { create_access_token(user.email) }
    let(:item) { create(:item, user: user) }
    let(:headers) { { Authorization: token } }
    let(:item_id) { item.id }
    let(:title) { FFaker::Book.title }
    let(:description) { FFaker::Book.description }
    let(:image_url) { FFaker::Book.cover }
    let(:variables) { { id: item_id, title: title, description: description, imageUrl: image_url } }
    let(:params) { { query: mutation, variables: variables } }
    let(:mutation) do
      <<~GQL
        mutation ($id: ID!, $title: String!, $description: String, $imageUrl: String) {
          updateItem(id: $id, title: $title, description: $description, imageUrl: $imageUrl) {
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

      it 'renders json with updated item' do
        expect(response).to match_schema(UpdateItemSchema::Success)
        expect(response).to be_ok
      end
    end

    describe 'Failure' do
      context 'when not authorized' do
        let(:headers) { {} }

        it 'renders json with error' do
          expect(response).to match_schema(UpdateItemSchema::NotAuthorized)
          expect(response).to be_ok
        end
      end

      context 'when invalid value' do
        let(:title) { nil }

        it 'renders json with error' do
          expect(response).to match_schema(UpdateItemSchema::InvalidParams)
          expect(response).to be_ok
        end
      end
    end
  end
end
