class Api::PetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
  end
end