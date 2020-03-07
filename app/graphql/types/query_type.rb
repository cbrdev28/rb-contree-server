# frozen_string_literal: true

module Types
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  class QueryType < Types::BaseObject
    # Our first query to experiment with Tutorial
    field :all_tutorials, [Types::TutorialType], null: false

    def all_tutorials
      Tutorial.all
    end

    # To query all users for parite (experiment)
    field :all_users, [Types::UserType], null: false

    def all_users
      User.all
    end

    # Fetch all lobbies
    field :all_lobbies, [Types::LobbyType], null: false

    def all_lobbies
      Lobby.all
    end

    # Fetch the first (and only one) lobby
    field :lobby, Types::LobbyType, null: true

    def lobby
      Lobby.first
    end

    # Fetch a parite game by id
    field :parite_game, Types::PariteGameType, null: true do
      description 'Find a parite game by id'
      argument :parite_game_id, ID, required: true
    end

    def parite_game(parite_game_id:)
      PariteGame.find(parite_game_id)
    end
  end
end
