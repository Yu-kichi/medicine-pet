require "rails_helper"

RSpec.describe ClinicScraper, type: :model do
  scenario "#create_file_names" do
    files = ClinicScraper.new.create_file_names
    expect("./db/seeds/clinics/01_hokkaido.text").to eq files[0]
    expect("./db/seeds/clinics/02_aomori.text").to eq files[1]
    expect("./db/seeds/clinics/47_okinawa.text").to eq files[46]
  end
end
