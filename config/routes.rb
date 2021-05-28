# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'

  get 'welcome/show'

  # Add route/mount for ActionCable
  mount ActionCable.server, at: '/cable_subscriptions'
end
