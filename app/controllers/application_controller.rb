# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def set_pets
    @pets = current_user.pets
  end
end
