# frozen_string_literal: true

class Pet < ApplicationRecord
  has_many :clinics
end
