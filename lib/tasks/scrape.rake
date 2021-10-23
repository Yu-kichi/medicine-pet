# frozen_string_literal: true

namespace :scrape do
  desc "病院情報を取得してファイルに保存"
  task clinic: :environment do
    file_names = ClinicScraper.new.create_file_names
    # 一度に取得したい範囲を"文字列で"設定する。
    ("01".."47").each do |num|
      text = ClinicScraper.new.parse_url(num)
      open(file_names[num.to_i - 1], "w") { |f|
        f.puts text
      }
    end
  rescue => e
    puts e
  end
end
