# frozen_string_literal: true

# The user auth token manager is meant to:
# - return the current user for a given token
# - register user and return the associated auth token
class UserAuthTokenManager
  # Class variable are discouraged by Rubocop rules, instead we could
  # use the Singleton pattern (supported by Ruby)
  # As a temporary solution for our session manager, I disabled
  # the Rubocop rules for these 2 class variables below

  # rubocop:disable Style/ClassVars

  # A class variable to store a hash of: { auth_token => user_id }
  # This is basically storing the user session
  @@user_session_table = {}

  # A class variable to store a hash of: { user_id => auth_token }
  # The reverse table of `user_session_table`
  # This is to keep track of users who already registered
  @@registered_user_table = {}

  # rubocop:enable Style/ClassVars

  # Returns the user associated with the given auth token
  def self.current_user(auth_token)
    user_id = @@user_session_table[auth_token]
    User.find_by(id: user_id)
  end

  # Registering user will generate an auth token and store it
  def self.register(user)
    auth_token = gen_auth_token(user)
    store_user_auth(user: user, auth_token: auth_token)
    auth_token
  end

  # Private helpers

  def self.gen_auth_token(user)
    "#{random_string}:#{user.id}"
  end

  def self.store_user_auth(user:, auth_token:)
    # If the same auth token is being used, we may have a PROBLEM!
    # - It can be the `random_string` function returned the same value
    #   - This is a temporary solution of my own (not secure anyway), so good for now
    # - Or somehow the same token is being used...
    # Check if we already have a matching value for the token to
    # prevent it by invalidating the user session and raising and exception
    unless @@user_session_table[auth_token].nil?
      invalidate_user_session(user: user, auth_token: auth_token)
      raise Constants::ERROR_DUPLICATE_AUTH_TOKEN
    end

    # If the same user is trying to register multiple times, prevent it
    # It's too risk to allow multiple auth token per user, basically
    # we only allow one session per user
    # Check if we find a token for the given user and remove it from
    # the registered table, and from the session table
    obsolete_auth_token = @@registered_user_table[user.id]
    invalidate_user_session(user: user, auth_token: auth_token) unless obsolete_auth_token.nil?

    # Register user in both table!
    @@registered_user_table[user.id] = auth_token
    @@user_session_table[auth_token] = user.id
  end

  def self.invalidate_user_session(user:, auth_token:)
    @@user_session_table.delete(auth_token)
    @@registered_user_table.delete(user.id)
  end

  def self.debug_session
    @@user_session_table
  end

  def self.debug_user
    @@registered_user_table
  end

  def self.random_string
    # Basically this makes a random string of 5 characters
    # I used the Rails console to understand that line, adapted from:
    # https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby
    length = 5
    (0...length).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
