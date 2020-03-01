# frozen_string_literal: true

# The user model class
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
