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

      all_cards = gen_deck
      all_cards.each do |a_card|
        card = Card.new(
          face_up: false,
          color: a_card[:color],
          value: a_card[:value],
          parite_game: parite_game
        )
        card.save!
      end

      parite_game.save!
      {
        parite_game: parite_game
      }
    end

    def gen_deck
      cards = []
      colors = %w[hearts diamonds clubs spades]
      colors.each do |color|
        (1..13).each do |x|
          cards.push(
            color: color,
            value: x
          )
        end
      end

      # Shuffle cards
      cards.shuffle
    end
  end
end
