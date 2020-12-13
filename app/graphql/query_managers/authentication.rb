# frozen_string_literal: true

module QueryManagers
  # Manager for authentication queries
  class Authentication
    # Query resolver for recover session
    def self.recover_session(_graphql_context:, auth_token:)
      user = UserAuthTokenManager.current_user(auth_token)
      raise Constants::ERROR_RECOVER_SESSION unless user

      {
        user: user,
        token: auth_token
      }
    end
  end
end
