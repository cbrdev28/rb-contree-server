# frozen_string_literal: true

module ApplicationCable
  # Base Connection class from Rails for ActionCable
  class Connection < ActionCable::Connection::Base
    def connect
      Rails.logger.debug 'ApplicationCable: connect'

      # Based from the doc: we have access to the request (instance private method)
      Rails.logger.debug "ApplicationCable: connect with request: #{request}"
    end
  end
end
