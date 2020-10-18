# frozen_string_literal: true

# The Rails generated class for User model
class User < ApplicationRecord
  # This is supported by the gem bcrypt
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
