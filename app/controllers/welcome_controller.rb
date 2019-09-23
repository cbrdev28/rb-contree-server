# frozen_string_literal: true

# My first class to show some json
class WelcomeController < ApplicationController
  def show
    @title = 'Welcome CBR controller'
    render :show
  end
end
