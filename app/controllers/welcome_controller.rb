# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

# My first class to show some json
class WelcomeController < ApplicationController
  def initialize
    @title = T.let('Welcome typed controller', String)
  end

  def show
    render :show
  end
end
