# frozen_string_literal: true

RSpec.describe Mutations::UpdateItemMutation do
  subject(:resolver) { described_class.new(object: nil, context: context).resolve(**params) }

  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:title) { FFaker::Book.title }
  let(:description) { FFaker::Book.description }
  let(:image_url) { FFaker::Book.cover }
  let(:context) { {} }
  let(:params) { { id: item.id, title: title, description: description, image_url: image_url } }

  context 'when user not authorized' do
    it 'raises an exception' do
      expect { resolver }.to raise_error(GraphQL::ExecutionError, Mutations::BaseMutation::AUTH_ERROR)
    end
  end

  context 'when item successful updated' do
    let(:context) { { current_user: user } }

    it 'returns hash with new item' do
      expect { resolver }
        .to change { item.reload.title }.from(item.title).to(title)
        .and change(item, :description).from(item.description).to(description)
        .and change(item, :image_url).from(item.image_url).to(image_url)
    end
  end

  context 'when item update has validation errors' do
    let(:user) { create(:user) }
    let(:context) { { current_user: user } }
    let(:title) { nil }

    it 'returns hash with error' do
      expect(resolver).to eq(errors: ["Title can't be blank"])
    end
  end
end
