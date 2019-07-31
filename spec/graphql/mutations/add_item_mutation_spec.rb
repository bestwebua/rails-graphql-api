# frozen_string_literal: true

module Mutations
  RSpec.describe AddItemMutation, type: :request do
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
      let(:user) { create(:user) }
      let(:token) { Base64.encode64(user.email) }
      let(:headers) { { Authorization: token } }

      # it '' do
      #   # binding.pry
      #   expect(response).to be_ok
      # end
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
