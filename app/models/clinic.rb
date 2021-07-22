# frozen_string_literal: true

class Clinic < ApplicationRecord
  belongs_to :prefecture
  has_many :prescriptions
  validates :name, presence: true
end
