# frozen_string_literal: true

module Types
  # GraphQL user model
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
  end
end
