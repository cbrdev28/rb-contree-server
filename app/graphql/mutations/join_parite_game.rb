# frozen_string_literal: true

module Mutations
  # Mutation for users to join a game of parite
  class JoinPariteGame < BaseMutation
    argument :user_id, ID, required: true
    argument :parite_game_id, ID, required: true

    field :parite_game, Types::PariteGameType, null: false

    def resolve(user_id:, parite_game_id:)
      user = User.find(user_id)
      parite_game = PariteGame.find(parite_game_id)
      player = Player.find_by(
        user: user,
        parite_game: parite_game
      )
      player ||= Player.new(
        user: user,
        parite_game: parite_game,
        ready: false
      )

      player.save!
      user.save!
      parite_game.save!
      {
        parite_game: parite_game
      }
    end
  end
end
