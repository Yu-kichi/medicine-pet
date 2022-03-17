# frozen_string_literal: true

module PetsHelper
  # 1月30日の一ヶ月後は次の月の月末のため、2月28日or29日になる。
  # そのため以下の計算式では月末前後の数日は誤差が生じる。
  # 例:31日が誕生日の場合、それより日数が少ない月の月末時点では一月経過していないことになる。
  # しかし厳密な経過月数計算は、不要かつ計算が複雑になると考えるため看過しています。

  def convert_to_age(birthday)
    today = Date.today
    total_month = (today.year - birthday.year) * 12 + today.month - birthday.month - (today.day >= birthday.day ? 0 : 1)
    year, month = total_month.divmod(12)
    "(#{year}歳#{month}ヶ月)"
  end
end
