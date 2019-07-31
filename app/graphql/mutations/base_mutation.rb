# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    AUTH_ERROR = 'You need to authenticate to perform this action'
    USER_NOT_FOUND_ERROR = 'User not found'

    def check_user!(user)
      return if user

      raise GraphQL::ExecutionError, USER_NOT_FOUND_ERROR
    end

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError, AUTH_ERROR
    end
  end
end
