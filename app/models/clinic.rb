# frozen_string_literal: true

class Clinic < ApplicationRecord
  belongs_to :prefecture
  belongs_to :user
  has_many :prescriptions
  validates :name, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :prefecture_id, presence: true
end
