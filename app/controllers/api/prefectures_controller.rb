# frozen_string_literal: true

module Api
  class PrefecturesController < ApplicationController
    before_action :authenticate_user!
    def index
      @prefectures = Prefecture.all.select(:id, :name)
    end
  end
end
