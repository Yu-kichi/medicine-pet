# frozen_string_literal: true

def prefectures(num)
  {
    "1" => "北海道",
    "2" => "青森県",
    "3" => "岩手県",
    "4" => "宮城県",
    "5" => "秋田県",
    "6" => "山形県",
    "7" =>"福島県",
    "8" =>"茨城県",
    "9" =>"栃木県",
    "10" =>"群馬県",
    "11" =>"埼玉県",
    "12" =>"千葉県",
    "13" =>"東京都",
    "14" =>"神奈川県",
    "15" =>"新潟県",
    "16" =>"富山県",
    "17" =>"石川県",
    "18" =>"福井県",
    "19" =>"山梨県",
    "20" =>"長野県",
    "21" =>"岐阜県",
    "22" =>"静岡県",
    "23" =>"愛知県",
    "24" =>"三重県",
    "25" =>"滋賀県",
    "26" =>"京都府",
    "27" =>"大阪府",
    "28" =>"兵庫県",
    "29" =>"奈良県",
    "30" =>"和歌山県",
    "31" =>"鳥取県",
    "32" =>"島根県",
    "33" =>"岡山県",
    "34" =>"広島県",
    "35" =>"山口県",
    "36" =>"徳島県",
    "37" =>"香川県",
    "38" =>"愛媛県",
    "39" =>"高知県",
    "40" =>"福岡県",
    "41" =>"佐賀県",
    "42" =>"長崎県",
    "43" =>"熊本県",
    "44" =>"大分県",
    "45" =>"宮崎県",
    "46" =>"鹿児島県",
    "47" =>"沖縄県",
  }[num]
end

file_names = []

Dir.foreach("db/seeds/clinics") do |item|
  next if (item == ".") || (item == "..")
  file_names << ("db/seeds/clinics/" + item)
end

# 一つ一つはいいが、連続して大量にやろうとするとエラーが出る。。
# file_names = %w(db/seeds/clinics/001_aomori.text)

# 単品ならいいいが全ファイルはメモリエラー、ここで新しく001ファイルを作る
# file_names.each_with_index do |file,i|
#   File.foreach(file).each_with_index do |line,num|
#     line.chomp
#     if num % 5 == 1
#       #p line
#      ac = line.match(/<a(?: .+?)?>/).post_match
#      prefecture = prefectures("9")
#      clinics << ac.match(/<\/a>/).pre_match + " (#{prefecture})"
#     elsif num % 5 == 3
#       clinics << line.chomp.split[2].gsub(",","")
#     elsif num % 5 == 4
#       ak = line.chomp.match(/:/).post_match
#       clinics << ak.gsub(',',"").gsub(' ',"")
#       ten << clinics
#       clinics = []
#     end
#   end
# end
#  pp ten
# pp clinics

# end
# pp clinics
