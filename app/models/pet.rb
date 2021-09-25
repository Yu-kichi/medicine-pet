# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :prescriptions, dependent: :destroy
  validates :name, presence: true
  validates :image,
            content_type: { in: %w[image/png image/jpg image/jpeg image/gif],
                            message: "はPNG, JPG, GIF形式にしてください" },
            size: { less_than_or_equal_to: 10.megabytes, message: "は10メガバイト以下にしてください" },
            dimension: { width: { max: 2000 }, height: { max: 2000 }, message: "が大きすぎます、横と縦の長さを2000以下にしてください" }

  attr_accessor :remove_image

  before_save :remove_image_if_user_accept

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end
end
