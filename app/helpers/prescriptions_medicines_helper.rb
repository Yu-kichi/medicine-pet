# frozen_string_literal: true

module PrescriptionsMedicinesHelper
  def medicine_options
    Medicine.all.map do |medicine|
      [medicine.name.to_s, medicine.id]
    end
  end
end
