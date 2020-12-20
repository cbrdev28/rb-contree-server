# frozen_string_literal: true

# Example from:
# https://graphql-ruby.org/subscriptions/subscription_type.html

# class Types::SubscriptionType < GraphQL::Schema::Object
# end

# Define the GraphQL type for subscription, same as the example above
# but this uses the same pattern than our mutation and query base types
module Types
  class SubscriptionType < Types::BaseObject
    # Declare subscriptions here, like we do with mutations
  end
end
