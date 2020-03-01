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

    # To query all users for parite (experiment)
    field :all_users, [Types::UserType], null: false

    def all_users
      User.all
    end
  end
end
