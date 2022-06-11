# frozen_string_literal: true

module Subscriptions
  # Our example class for subscriptions
  class ExampleSubscription < Subscriptions::BaseSubscription
    # Most of implementation commented out for now, to keep things simple first

    # argument :example_arg, ID, required: true

    # We must define a field type (return value), required to build schema
    field :example_response, String, null: true

    # def subscribe(example_arg: nil)
    #   Rails.logger.debug "ExampleSubscription: subscribe #{example_arg}"
    #   # Return initial value
    #   {
    #     example_response: 'Initial value'
    #   }
    # end

    # def update(example_arg: nil)
    #   Rails.logger.debug "ExampleSubscription: update #{example_arg}"
    #   # Return some debug value
    #   {
    #     example_response: 'Debug value'
    #   }
    # end
  end
end
