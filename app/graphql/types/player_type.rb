# frozen_string_literal: true

module Types
  # GraphQL model for player
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :ready, Boolean, null: false

    field :user, Types::UserType, null: false
    field :parite_game, Types::PariteGameType, null: false
  end
end