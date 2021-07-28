# frozen_string_literal: true

# データファイル一括取得
file_names = []
Dir.foreach("db/seeds/clinics") do |item|
  next if (item == ".") || (item == "..")
  file_names << ("db/seeds/clinics/" + item)
end

file_names = file_names.sort
# データ投入できるが時間はかかる。。
file_names.each_with_index do |file, i|
  File.foreach(file) do |line|
    line = line.split(",")
    Clinic.create(
      name: line[0],
      address: line[1],
      telephone_number: line[2],
      prefecture_id: i+1
    )
  end
end
