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

  # The error when the sign in mutation fails:
  # - No credentials passed
  # - No user found by email
  # - Bad credentials
  # - Not able to generate a token
  ERROR_SIGN_IN = 'Error: sign in failed'

  # The error when no recover session is available for a given token
  ERROR_RECOVER_SESSION = 'Error: no recover session available'

  # The error when no current user can be found during logout
  ERROR_LOGOUT = 'Error: you must be logged in'
end
