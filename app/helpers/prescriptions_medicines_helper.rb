# frozen_string_literal: true

module PrescriptionsMedicinesHelper
  def medicine_options
    Medicine.all.map do |medicine|
      ["#{medicine.name}", medicine.id]
    end
  end
end
