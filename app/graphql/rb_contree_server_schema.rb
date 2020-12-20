# frozen_string_literal: true

# Generated GraphQL class
class RbContreeServerSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # We defined a type for subscription, adding it to the schema
  subscription(Types::SubscriptionType)
end
