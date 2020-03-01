# frozen_string_literal: true

# The user model class
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :lobby, optional: true
end
