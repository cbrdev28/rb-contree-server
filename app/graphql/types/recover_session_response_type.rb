# frozen_string_literal: true

module Types
  # The GraphQL class for the recover query response
  class RecoverSessionResponseType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :token, String, null: false
  end
end
