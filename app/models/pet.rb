# frozen_string_literal: true

class Pet < ApplicationRecord
  has_many :prescriptions, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  validates :name, uniqueness: true
  validate :image_type

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
end
