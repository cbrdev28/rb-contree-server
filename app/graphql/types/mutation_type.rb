# frozen_string_literal: true

module Types
  # Entry class to define GraphQL mutations
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field,
          String,
          null: false,
          description: 'An example field added by the generator'

    def test_field
      'Hello World'
    end

    # Our first mutation to experiment with Tutorial
    field :create_tutorial, mutation: Mutations::CreateTutorial

    # Our mutation to create users for parite!
    field :create_user, mutation: Mutations::CreateUser

    # Mutation to make user join the lobby
    field :join_lobby, mutation: Mutations::JoinLobby

    # Create game for parite
    field :create_parite_game, mutation: Mutations::CreatePariteGame
  end
end
