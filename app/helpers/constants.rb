# frozen_string_literal: true

# This module is only meant to hold constants
# This is a first approach to avoid hard coding constants in the code
# And to gather them in one place for now
module Constants
  # The error message when somehow an attempt is made to use an
  # existing auth token for a different user session
  ERROR_DUPLICATE_AUTH_TOKEN = 'Error: auth token already existing'

  # The name of our custom header to retrieve the current user
  # authentication token
  HEADER_CONTREE_AUTH_TOKEN = 'Contree-Auth-Token'
end
