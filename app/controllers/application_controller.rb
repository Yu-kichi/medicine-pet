# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def set_pets
    @pets = current_user.pets
  end

  def admin_login?
    user_signed_in? && current_user.admin?
  end
end
