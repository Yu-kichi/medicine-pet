# frozen_string_literal: true

module PrescriptionsHelper
  def clinic_options
    Clinic.all.map do |clinic|
      ["#{clinic.name}", clinic.id]
    end
  end
end
