module GraphqlControllerHelper
  def self.graphql_context
    { current_user: nil }
  end

  def self.auth_token_from_header(request)
    # The first? constant I am hard coding
    request.headers['Contree-Auth-Token']
  end
end
