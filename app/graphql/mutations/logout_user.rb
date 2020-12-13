# frozen_string_literal: true

module Mutations
  # GraphQL mutation to logout user
  class LogoutUser < Mutations::BaseMutation
    def resolve
      # Make sure we are logged in!
      current_user = context[:current_user]
      raise Constants::ERROR_NOT_LOGGED_IN unless current_user

      UserAuthTokenManager.logout(current_user)

      # Return empty object
      {}
    end
  end
end
