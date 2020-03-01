# frozen_string_literal: true

# Rails class model for Lobby
class Lobby < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :users, dependent: :nullify
end
