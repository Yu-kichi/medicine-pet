# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :prescriptions, dependent: :destroy
  validates :name, presence: true
  validates :image,
            content_type: { in: %w[image/png image/jpg image/jpeg image/gif],
                            message: "はPNG, JPG, GIF形式にしてください" },
            dimension: { width: { max: 2000 }, height: { max: 2000 }, message: "が大きすぎます、横と縦の長さを2000以下にしてください" }
end
