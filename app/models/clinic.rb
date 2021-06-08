# frozen_string_literal: true

class Clinic < ApplicationRecord
  belongs_to :pet
  has_many :medicines
end