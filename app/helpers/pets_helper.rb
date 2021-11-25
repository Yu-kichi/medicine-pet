# frozen_string_literal: true

module PetsHelper
  def birthday_to_age(birthday)
    date = (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 100
    year = date / 100
    month = date % 100
    "(#{year}歳#{month}ヶ月)"
  end
end
