# frozen_string_literal: true

# My first class to show some json
class WelcomeController < ApplicationController
  def initialize
    super
    @title = 'Welcome controller'
  end

  def show
    render :show
  end
end
