# frozen_string_literal: true

# A channel for GraphQL to support Subscriptions
class GraphqlChannel < ApplicationCable::Chanel
  # Implementation taken (adapted) from:
  # https://graphql-ruby.org/api-doc/1.11.6/GraphQL/Subscriptions/ActionCableSubscriptions.html
  # Documentation from a higher version may improve this code a little
  def subscribed
    Rails.logger.debug 'GraphqlChannel: subscribed'
    @subscription_ids = []
  end

  def execute(data)
    Rails.logger.debug 'GraphqlChannel: execute'

    query = data['query']
    variables = ensure_hash(data['variables'])
    operation_name = data['operationName']
    context = {
      # TODO: get current user from the parent Connection class and pass to context
      # current_user: current_user,
      channel: self
    }

    result = RbContreeServerSchema.execute(
      {
        query: query,
        context: context,
        variables: variables,
        operation_name: operation_name
      }
    )

    payload = {
      result: result.to_h,
      more: result.subscription?
    }

    # Track the subscription here so we can remove it
    # on unsubscribe.
    @subscription_ids << result.context[:subscription_id] if result.context[:subscription_id]

    transmit(payload)
  end

  def unsubscribed
    Rails.logger.debug 'GraphqlChannel: unsubscribed'
    @subscription_ids.each do |sid|
      RbContreeServerSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

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
end
