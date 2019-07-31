# frozen_string_literal: true

module SignInSchema
  Success = Dry::Schema.Params do
    required(:data).value(:hash).schema do
      required(:signIn).value(:hash).schema do
        required(:token).value(:string)
        required(:user).value(:hash).schema do
          required(:id).value(:integer)
          required(:fullName).value(:string)
        end
      end
    end
  end

  UserNotFound = Dry::Schema.Params do
    required(:data).value(:hash).schema do
      required(:signIn).value(:none?)
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
