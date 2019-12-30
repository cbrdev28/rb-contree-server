# frozen_string_literal: true

module Types
  # GraphQL model object for our first Tutorial experiment
  class TutorialType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
  end
end
