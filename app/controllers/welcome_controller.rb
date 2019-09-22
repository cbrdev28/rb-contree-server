# frozen_string_literal: true

class WelcomeController < ApplicationController
  def show
    @title = 'Welcome CBR controller'
    render :show
  end
end
