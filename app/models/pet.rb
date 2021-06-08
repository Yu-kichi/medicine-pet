# frozen_string_literal: true

class Pet < ApplicationRecord
  has_many :clinics, dependent: :destroy
  has_many :medicines, dependent: :destroy
end
