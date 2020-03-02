# frozen_string_literal: true

# Rails class model for a card
class Card < ApplicationRecord
  validates :face_up, default: false
  validates :color, presence: true
  validates :value, presence: true

  belongs_to :player, optional: true
  belongs_to :parite_game, optional: true
end
