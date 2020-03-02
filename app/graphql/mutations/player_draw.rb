# frozen_string_literal: true

module Mutations
  # To draw card and put it in player hand
  class PlayerDraw < BaseMutation
    argument :player_id, ID, required: true
    argument :parite_game_id, ID, required: true

    field :parite_game, Types::PariteGameType, null: false

    def resolve(player_id:, parite_game_id:)
      parite_game = PariteGame.find(parite_game_id)
      card = Card.find_by(
        parite_game: parite_game
      )
      player = Player.find(player_id)
      card.update(
        parite_game: nil,
        player: player
      )
      card.save!
      player.save!

      parite_game.save!
      {
        parite_game: parite_game
      }
    end
  end
end
