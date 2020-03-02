# frozen_string_literal: true

# Rails class for player model
class Player < ApplicationRecord
  validates :ready, presence: true

  belongs_to :user
  belongs_to :parite_game
end
