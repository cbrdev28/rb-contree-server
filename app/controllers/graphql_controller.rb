# frozen_string_literal: true

# Generated GraphQL class
class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = graphql_context(session)

    result = RbContreeServerSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Returns the context for our GraphQL queries
  # We pass the Rails session, a sort of hash provided by Rails,
  # where I would like to store the authentication token for the
  # current user. This will be done by the sign in mutation.
  # We also pass a way to retrieve the current user, which lets
  # other queries check if the query is from a logged-in user.
  def graphql_context(session)
    Rails.logger.info "params: #{session}"
    {
      session: session
    }
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render(
      json: {
        error: {
          message: err.message,
          backtrace: err.backtrace
        },
        data: {}
      },
      status: :internal_server_error
    )
  end
end
