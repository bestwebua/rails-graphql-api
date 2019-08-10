# frozen_string_literal: true

module Mutations
  class UpdateItemMutation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false
    argument :image_url, String, required: false

    field :item, Types::ItemType, null: true
    field :errors, [String], null: true

    def resolve(id:, title:, description: nil, image_url: nil)
      check_authentication!

      item = Item.find(id)
      return { errors: item.errors.full_messages } unless item.update(title: title, description: description, image_url: image_url)

      RailsGraphqlApiSchema.subscriptions.trigger('itemUpdated', {}, item)
      { item: item }
    end
  end
end
