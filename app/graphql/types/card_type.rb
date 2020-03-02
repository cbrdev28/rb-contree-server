# frozen_string_literal: true

module Types
  # GraphQL model for card
  class CardType < Types::BaseObject
    field :id, ID, null: false
    field :face_up, Boolean, null: true
    field :color, String, null: false
    field :value, Integer, null: false

    field :player, Types::PlayerType, null: true
    field :parite_game, Types::PariteGameType, null: true
  end
end
