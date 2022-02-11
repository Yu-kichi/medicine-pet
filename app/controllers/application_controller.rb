# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :admin_login?
  
  protected
    def set_pets
      @pets = current_user.pets
    end

    def admin_login?
      user_signed_in? && current_user.admin?
    end
end
