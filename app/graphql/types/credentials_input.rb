# frozen_string_literal: true

module Types
  # We define a type for the input required for users to authenticate
  class CredentialsInput < Types::BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
