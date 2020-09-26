# frozen_string_literal: true

# Rails migration class to add lobby reference to user
class AddLobbyToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :lobby, foreign_key: true
  end
end
