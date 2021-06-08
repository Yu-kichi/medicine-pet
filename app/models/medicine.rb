# frozen_string_literal: true

class Medicine < ApplicationRecord
  belongs_to :clinic
  belongs_to :pet
end
