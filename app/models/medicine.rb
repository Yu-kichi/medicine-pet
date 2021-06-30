# frozen_string_literal: true

class Medicine < ApplicationRecord
  has_many :prescriptions_medicines
end
