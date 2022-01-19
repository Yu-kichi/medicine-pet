# frozen_string_literal: true

class API::PrefecturesController < API::BaseController
  before_action :authenticate_user!
  def index
    @prefectures = Prefecture.all.select(:id, :name)
  end
end
