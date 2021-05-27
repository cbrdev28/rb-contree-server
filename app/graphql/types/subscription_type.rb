# frozen_string_literal: true

# Example from:
# https://graphql-ruby.org/subscriptions/subscription_type.html

# This example snippet can be deleted
# class Types::SubscriptionType < GraphQL::Schema::Object
# end

module Types
  # Define the GraphQL type for subscription, same as the example above
  # but this uses the same pattern than our mutation and query base types
  class SubscriptionType < Types::BaseObject
    # Declare subscriptions here, like we do with mutations

    # Example of declaring a subscription with its own class, like mutations
    field :example_subscription, subscription: Subscriptions::ExampleSubscription
  end
end
