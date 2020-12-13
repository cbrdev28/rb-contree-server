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

    # Our mutation to create user with name, email & password (bcrypt)
    field :create_user, mutation: Mutations::CreateUser

    # Mutation to sign in user
    field :sign_in_user, mutation: Mutations::SignInUser

    # Mutation to logout user
    field :logout_user, mutation: Mutations::LogoutUser
  end
end
