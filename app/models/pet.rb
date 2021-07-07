# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :prescriptions, dependent: :destroy
  validate :image_type

  attr_accessor :remove_image

  before_save :remove_image_if_user_accept

  def image_type
    if image.attached?
      if !image_file?
        errors.add(:image, "needs to be a JPEG or PNG")
      end
    end
  end

  def image_file?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end
end
