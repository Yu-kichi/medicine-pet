# frozen_string_literal: true

module PetsHelper
  # 年齢の計算方法
  # (現在年×10000+現在月×100+現在日)−(誕生年×10000+誕生月×100+誕生日)/10000 で現在の年齢が計算できる。1万差があると1年経過

  # 月数経過の計算方法
  # 一月以上経過から一年未満の差は8900~9999までの範囲になる。例:(20220101-20211201)=8900
  # 差が大きい程経過日数が多いため月の経過月数は最終的に12からの差で求める  例:12 - (100 - 8900 / 100) = 1   =>1ヶ月経過
  # 一月経過しない場合は差が二桁に収まるのでその場合8800とみなす。

  def convert_to_age(birthday)
    difference = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i)
    year = difference / 10000
    difference = difference - year * 10000
    difference = 8800 if difference < 8899
    month = 12 - (100 - difference / 100)
    "(#{year}歳#{month}ヶ月)"
  end
end
