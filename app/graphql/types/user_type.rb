# frozen_string_literal: true

module Types
  # The GraphQL generated class for User type
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
  end
end
