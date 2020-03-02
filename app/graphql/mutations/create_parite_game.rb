# frozen_string_literal: true

module Mutations
  # Our first mutation to create games of parite
  class CreatePariteGame < BaseMutation
    argument :title, String, required: true
    argument :lobby_id, ID, required: false

    field :parite_game, Types::PariteGameType, null: false

    def resolve(title:, lobby_id: nil)
      lobby = lobby_id && Lobby.find(lobby_id) || Lobby.first
      parite_game = PariteGame.new(
        title: title,
        lobby: lobby
      )

      parite_game.save!
      {
        parite_game: parite_game
      }
    end
  end
end
