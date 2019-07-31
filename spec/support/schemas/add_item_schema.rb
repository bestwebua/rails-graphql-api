# frozen_string_literal: true

module AddItemSchema
  NotAuthorized = Dry::Schema.Params do
    required(:data).value(:hash?).schema do
      required(:addItem).value(:none?)
    end
    required(:errors).value(:array).each do
      schema do
        required(:message).value(:string)
        required(:path).value(:array).each(:str?)
      end
    end
  end

  InvalidParams = Dry::Schema.Params do
    required(:errors).value(:array).each(:hash) do
      schema do
        required(:message).value(:string)
        required(:extensions).value(:hash)
      end
    end
  end
end
