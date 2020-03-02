# frozen_string_literal: true

module Types
  # GraphQL model for parite game
  class PariteGameType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false

    field :lobby, Types::LobbyType, null: false
  end
end
