# frozen_string_literal: true

module AddItemSchema
  Success = Dry::Schema.Params do
    required(:data).value(:hash).schema do
      required(:addItem).value(:hash).schema do
        required(:item).value(:hash).schema do
          required(:id).value(:integer)
          required(:title).value(:string)
          optional(:description).maybe(:string)
          optional(:imageUrl).maybe(:string)
        end
        required(:errors).value(:none?)
      end
    end
  end

  NotAuthorized = Dry::Schema.Params do
    required(:data).value(:hash).schema do
      required(:addItem).value(:none?)
    end
    required(:errors).value(:array).each do
      schema do
        required(:message).value(:string)
        required(:path).value(:array).each(:string)
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
