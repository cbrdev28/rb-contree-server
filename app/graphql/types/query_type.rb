# frozen_string_literal: true

module Types
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  class QueryType < Types::BaseObject
    # Our first query to experiment with Tutorial
    field :all_tutorials, [Types::TutorialType], null: false

    def all_tutorials
      Tutorial.all
    end
  end
end
