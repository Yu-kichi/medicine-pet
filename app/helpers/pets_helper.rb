# frozen_string_literal: true

module PetsHelper
  def convert_to_age(birthday)
    difference = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i)
    year = difference / 10000
    difference = difference - year * 10000
    difference = 8800 if difference < 8899
    month = 12 - (100 - difference / 100)
    "(#{year}歳#{month}ヶ月)"
  end
end
