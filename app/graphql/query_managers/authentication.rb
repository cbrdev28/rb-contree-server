# frozen_string_literal: true

module QueryManagers
  # Manager for authentication queries
  class Authentication
    # Query resolver for recover session
    def self.recover_session(auth_token)
      user = UserAuthTokenManager.current_user(auth_token)
      if user
        return {
          user: user,
          token: auth_token
        }
      end

      {
        user: nil,
        token: nil
      }
    end

    def self.current_user(graphql_context)
      current_user = graphql_context[:current_user]
      raise Constants::ERROR_NOT_LOGGED_IN unless current_user

      current_user
    end
  end
end