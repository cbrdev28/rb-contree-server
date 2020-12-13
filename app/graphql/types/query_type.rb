# frozen_string_literal: true

module Types
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # We will define all of our queries directly in this file.
  # If it becomes too much for one file, check in the Runbook.md
  # for some links/resources on how to change that.
  class QueryType < Types::BaseObject
    # Query:
    # Our first query to experiment with Tutorial
    field :all_tutorials, [Types::TutorialType], null: false

    def all_tutorials
      Tutorial.all
    end

    # Query to recover user session from the auth token
    # It takes the token as input parameter
    # If success, it returns the user object and token
    field :recover_session, Types::RecoverSessionResponseType, null: true do
      description 'Fetch user session from auth token'
      argument :auth_token, String, required: true
    end

    def recover_session(auth_token:)
      QueryManagers::Authentication.recover_session(graphql_context: context, auth_token: auth_token)
    end
  end
end
