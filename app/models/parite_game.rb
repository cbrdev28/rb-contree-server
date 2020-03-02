# frozen_string_literal: true

# Rails class model for a game of parite
class PariteGame < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :lobby
  has_many :players, dependent: :destroy
end
