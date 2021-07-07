# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :prescriptions, dependent: :destroy
  validates :image, 
    content_type: [:png, :jpg, :jpeg],
    size: {less_than_or_equal_to: 10.megabytes},
    dimension: {width: {max:2000}, height: {max: 2000}}
  
  attr_accessor :remove_image
 
  before_save :remove_image_if_user_accept

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end
end
