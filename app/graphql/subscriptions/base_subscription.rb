# frozen_string_literal: true

module Subscriptions
  # https://graphql-ruby.org/subscriptions/subscription_classes
  # Define our base class for Subscription
  class BaseSubscription < GraphQL::Schema::Subscription
    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject
  end
end
