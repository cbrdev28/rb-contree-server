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
