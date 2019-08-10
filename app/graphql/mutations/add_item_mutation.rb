# frozen_string_literal: true

module Mutations
  class AddItemMutation < Mutations::BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :image_url, String, required: false

    field :item, Types::ItemType, null: true
    field :errors, [String], null: true

    def resolve(title:, description: nil, image_url: nil)
      check_authentication!

      item = Item.new(title: title, description: description, image_url: image_url, user: context[:current_user])
      return { errors: item.errors.full_messages } unless item.save

      RailsGraphqlApiSchema.subscriptions.trigger('itemAdded', {}, item)
      { item: item }
    end
  end
end
