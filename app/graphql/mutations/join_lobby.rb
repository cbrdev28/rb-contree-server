# frozen_string_literal: true

module Mutations
  # Join lobby mutation
  class JoinLobby < BaseMutation
    argument :user_id, ID, required: true

    field :lobby, Types::LobbyType, null: false

    def resolve(user_id:)
      lobby = Lobby.first
      lobby ||= Lobby.new(
        title: 'Greg & Bazoo Lobby'
      )

      user = User.find(user_id)
      user.update(lobby: lobby)

      lobby.save!
      {
        lobby: lobby
      }
    end
  end
end
