# frozen_string_literal: true

RSpec.describe Types::QueryType do
  subject(:result) { RailsGraphqlApiSchema.execute(query).to_h }

  describe '#items' do
    let!(:items) { create_pair(:item).map { |item| { 'title' => item.title } } }
    let(:query) { %(query { items { title }}) }

    specify { expect(result.dig('data', 'items')).to match_array(items) }
  end
end
