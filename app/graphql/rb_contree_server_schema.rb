# frozen_string_literal: true

# Generated GraphQL class
class RbContreeServerSchema < GraphQL::Schema
  # We use ActionCable to support Subscriptions with GraphQL
  # https://graphql-ruby.org/api-doc/1.11.6/GraphQL/Subscriptions/ActionCableSubscriptions.html
  # use GraphQL::Subscriptions::ActionCableSubscriptions
  # For redis usage
  # use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new

  mutation(Types::MutationType)
  query(Types::QueryType)

  # We defined a type for subscription, adding it to the schema
  subscription(Types::SubscriptionType)
end
