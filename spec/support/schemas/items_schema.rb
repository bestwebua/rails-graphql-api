# frozen_string_literal: true

module ItemsSchema
  Success = Dry::Schema.Params do
    required(:data).value(:hash).schema do
      required(:items).value(:array).each do
        schema do
          required(:id).value(:integer)
          required(:title).value(:string)
          optional(:description).maybe(:string)
          optional(:imageUrl).maybe(:string)
          required(:user).value(:hash).schema do
            required(:id).value(:integer)
            required(:email).value(:string)
            required(:fullName).value(:string)
          end
        end
      end
    end
  end
end
