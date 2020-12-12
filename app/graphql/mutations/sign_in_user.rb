# frozen_string_literal: true

module Mutations
  # GraphQL mutation to sign in user, which will
  # - Find user by email
  # - Use brcypt `authenticate()` to verify password
  # - Register user by creating a session and a token
  # - Return the user object and token if all good
  #   - Otherwise return null
  class SignInUser < Mutations::BaseMutation
    argument :credentials, Types::CredentialsInput, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(credentials: nil)
      raise Constants::ERROR_SIGN_IN unless credentials

      user = User.find_by(email: credentials&.[](:email))
      raise Constants::ERROR_SIGN_IN unless user
      raise Constants::ERROR_SIGN_IN unless user.authenticate(credentials&.[](:password))

      auth_token = UserAuthTokenManager.register(user)
      raise Constants::ERROR_SIGN_IN unless auth_token

      {
        user: user,
        token: auth_token
      }
    end
  end
end
