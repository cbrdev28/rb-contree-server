# frozen_string_literal: true

# Rails class for player model
class Player < ApplicationRecord
  validates :ready, default: false

  belongs_to :user
  belongs_to :parite_game
  has_many :cards, dependent: :nullify
end
