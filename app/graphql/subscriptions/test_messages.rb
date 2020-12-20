# frozen_string_literal: true

module Subscriptions
  # Our class to test subscriptions
  class TestMessages < Subscriptions::BaseSubscription
    argument :test_id, ID, required: true

    field :messages, [String], null: false

    def subscribe(test_id: nil)
      Rails.logger.warn "TestMessages Subscription: subscribe #{test_id}"

      # Return initial value
      {
        messages: ['First init value', 'Second init value']
      }
    end

    def update(test_id: nil)
      Rails.logger.warn 'TestMessages Subscription: update'
      # Return some debug value
      {
        messages: ['One value from update']
      }
    end
  end
end
