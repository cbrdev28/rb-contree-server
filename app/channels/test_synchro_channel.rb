# frozen_string_literal: true

class TestSynchroChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'test_synchro'
  end

  # def synchro(_data)
  #   message = 'Test synchro'
  #   payload = { message: message }
  #   TestSynchroChannel.broadcast_to('test_synchro', payload)
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
