# frozen_string_literal: true

module Api
  class PetsController < ApplicationController
    before_action :authenticate_user!
    def index
      @pets = current_user.pets
    end
  end
end
