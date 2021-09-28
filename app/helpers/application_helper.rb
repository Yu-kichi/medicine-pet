# frozen_string_literal: true

module ApplicationHelper
  def admin_login?
    user_signed_in? && current_user.admin?
  end
end
