# frozen_string_literal: true

module Mutations
  # Our first mutation to make users
  class CreateUser < BaseMutation
    argument :name, String, required: true

    field :user, Types::UserType, null: false

    def resolve(name:)
      lobby = Lobby.first
      lobby ||= Lobby.new(
        title: 'Greg & Bazoo Lobby'
      )

      user = User.new(
        name: name,
        lobby: lobby
      )

      lobby.save!
      user.save!
      {
        user: user
      }
    end
  end
end
