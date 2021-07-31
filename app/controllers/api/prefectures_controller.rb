# frozen_string_literal: true

class Api::PrefecturesController < ApplicationController
  before_action :authenticate_user!
  def index
    @prefectures = Prefecture.all.select(:id, :name)
  end
end
