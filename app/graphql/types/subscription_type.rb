# frozen_string_literal: true

# Example from:
# https://graphql-ruby.org/subscriptions/subscription_type.html

# class Types::SubscriptionType < GraphQL::Schema::Object
# end

module Types
  # Define the GraphQL type for subscription, same as the example above
  # but this uses the same pattern than our mutation and query base types
  class SubscriptionType < Types::BaseObject
    # Declare subscriptions here, like we do with mutations

    field :test_messages, subscription: Subscriptions::TestMessages
  end
end
