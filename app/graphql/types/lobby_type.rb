# frozen_string_literal: true

module Types
  # GraphQL class model for Lobby
  class LobbyType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false

    field :users, [Types::UserType], null: true
    field :parite_games, [Types::PariteGameType], null: true
  end
end
