# frozen_string_literal: true

RSpec.describe Mutations::AddItemMutation do
  subject(:resolver) { described_class.new(object: nil, context: context).resolve(**params) }

  let(:title) { FFaker::Book.title }
  let(:description) { FFaker::Book.description }
  let(:image_url) { FFaker::Book.cover }
  let(:context) { {} }
  let(:params) { { title: title, description: description, image_url: image_url } }

  context 'when user not authorized' do
    it 'raises an exception' do
      expect { resolver }.to raise_error(GraphQL::ExecutionError, Mutations::BaseMutation::AUTH_ERROR)
    end
  end

  context 'when item successful saved' do
    let(:user) { create(:user) }
    let(:context) { { current_user: user } }

    it 'returns hash with new item' do
      expect { resolver }.to change(user.items, :count).from(0).to(1)
      expect(resolver).to eq(item: user.items.last)
    end
  end

  context 'when item has validation errors' do
    let(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:title) { nil }

    it 'returns hash with error' do
      expect(resolver).to eq(errors: ["Title can't be blank"])
    end
  end
end
