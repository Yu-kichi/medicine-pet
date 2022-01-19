# frozen_string_literal: true

class API::PetsController < API::BaseController
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
  end
end
