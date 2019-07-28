# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :items, [Types::ItemType], null: false, description: 'Returns a list of items'

    def items
      Item.preload(:user)
    end
  end
end
