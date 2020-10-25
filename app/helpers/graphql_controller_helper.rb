# frozen_string_literal: true

# This module is a helper to create the context for the GraphQl controller
# It has a helper method to parse the `auth_token` from the request headers
# And another method to make the GraphQl context object by passing a way to
# get the `current_user`
module GraphqlControllerHelper
  def self.graphql_context(request)
    auth_token = auth_token_from_header(request)
    { current_user: UserAuthTokenManager.current_user(auth_token) }
  end

  def self.auth_token_from_header(request)
    # The first? constant I am hard coding
    request.headers['Contree-Auth-Token']
  end
end
