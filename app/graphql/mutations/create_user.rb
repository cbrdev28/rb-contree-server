# frozen_string_literal: true

module Mutations
  # GraphQL mutation to create an user
  class CreateUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :credentials, Types::CredentialsInput, required: true

    field :user, Types::UserType, null: false

    def resolve(name:, credentials:)
      user = User.create!(
        name: name,
        email: credentials&.[](:email),
        password: credentials&.[](:password)
      )
      {
        user: user
      }
    end
  end
end
