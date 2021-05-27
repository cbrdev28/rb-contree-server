# frozen_string_literal: true

module Subscriptions
  # Our example class for subscriptions
  class ExampleSubscription < Subscriptions::BaseSubscription
    # Most of implementation commented out for now, to keep things simple first

    # argument :example_arg, ID, required: true

    # We must define a field type (return value)
    field :example_response, String, null: true

    # def subscribe(example_arg: nil)
    #   Rails.logger.warn "ExampleSubscription: subscribe #{example_arg}"
    #   # Return initial value
    #   {
    #     messages: 'Initial value'
    #   }
    # end

    # def update(example_arg: nil)
    #   Rails.logger.warn "ExampleSubscription: update #{example_arg}"
    #   # Return some debug value
    #   {
    #     messages: 'Debug value'
    #   }
    # end
  end
end
