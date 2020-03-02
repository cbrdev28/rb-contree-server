# frozen_string_literal: true

module Types
  # GraphQL model for player
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :ready, Boolean, null: true

    field :user, Types::UserType, null: false
    field :parite_game, Types::PariteGameType, null: false
    field :cards, [Types::CardType], null: true
  end
end
