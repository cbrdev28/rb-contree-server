# frozen_string_literal: true

module Mutations
  # Our first mutation to make users
  class CreateUser < BaseMutation
    argument :name, String, required: true

    field :user, Types::UserType, null: false

    def resolve(name:)
      user = User.new(
        name: name
      )
      user.save!

      {
        user: user
      }
    end
  end
end
