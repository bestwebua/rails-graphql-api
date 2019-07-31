# frozen_string_literal: true

class RailsGraphqlApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
