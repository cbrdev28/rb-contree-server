# frozen_string_literal: true

module Mutations
  # Our first mutation to experiment with Tutorial
  class CreateTutorial < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false

    field :tutorial, Types::TutorialType, null: false
    field :errors, [String], null: false

    def resolve(title:, description: nil)
      tutorial = Tutorial.new(
        title: title,
        description: description
      )
      if tutorial.save
        # Test our subscription here
        RbContreeServerSchema.subscriptions.trigger('exampleSubscription', {}, "Triggered valued: title: #{title}")
        {
          tutorial: tutorial,
          errors: []
        }
      else
        {
          tutorial: nil,
          errors: tutorial.errors.full_messages
        }
      end
    end
  end
end
