# frozen_string_literal: true

module Types
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # We will define all of our queries directly in this file.
  # If it becomes too much for one file, check in the Runbook.md
  # for some links/resources on how to change that.
  class QueryType < Types::BaseObject
    # Query:
    # Our first query to experiment with Tutorial
    field :all_tutorials, [Types::TutorialType], null: false

    def all_tutorials
      Tutorial.all
    end
  end
end
