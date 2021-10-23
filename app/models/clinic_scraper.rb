# frozen_string_literal: true

require "open-uri"
require "nokogiri"

class ClinicScraper
  def initialize
    @prefecture_clinic_list = <<-"EOS"
    北海道 (514)
    青森県 (73)
    岩手県 (92)
    宮城県 (192)
    秋田県 (45)
    山形県 (79)
    福島県 (173)
    茨城県 (292)
    栃木県 (230)
    群馬県 (235)
    埼玉県 (668)
    千葉県 (600)
    東京都 (1592)
    神奈川県 (1019)
    新潟県 (152)
    富山県 (54)
    石川県 (87)
    福井県 (40)
    山梨県 (84)
    長野県 (184)
    岐阜県 (156)
    静岡県 (341)
    愛知県 (646)
    三重県 (151)
    滋賀県 (100)
    京都府 (224)
    大阪府 (702)
    兵庫県 (506)
    奈良県 (109)
    和歌山県 (74)
    鳥取県 (52)
    島根県 (48)
    岡山県 (129)
    広島県 (220)
    山口県 (115)
    徳島県 (64)
    香川県 (78)
    愛媛県 (103)
    高知県 (55)
    福岡県 (412)
    佐賀県 (49)
    長崎県 (98)
    熊本県 (169)
    大分県 (95)
    宮崎県 (103)
    鹿児島県 (178)
    沖縄県 (97)
    EOS

    @prefecture_name = <<-"EOS"
    hokkaido
    aomori
    iwate
    miyagi
    akita
    yamagata
    fukushima
    ibaraki
    tochigi
    gunma
    saitama
    chiba
    tokyo
    kanagawa
    niigata
    toyama
    ishikawa
    fukui
    yamanashi
    nagano
    gifu
    shizuoka
    aichi
    mie
    shiga
    kyoto
    osaka
    hyogo
    nara
    wakayama
    tottori
    shimane
    okayama
    hiroshima
    yamaguchi
    tokushima
    kagawa
    ehime
    kochi
    fukuoka
    saga
    nagasaki
    kumamoto
    oita
    miyazaki
    kagoshima
    okinawa
    EOS
  end

  def prefectures(num)
    {
      "01" => "北海道",
      "02" => "青森県",
      "03" => "岩手県",
      "04" => "宮城県",
      "05" => "秋田県",
      "06" => "山形県",
      "07" => "福島県",
      "08" => "茨城県",
      "09" => "栃木県",
      "10" => "群馬県",
      "11" => "埼玉県",
      "12" => "千葉県",
      "13" => "東京都",
      "14" => "神奈川県",
      "15" => "新潟県",
      "16" => "富山県",
      "17" => "石川県",
      "18" => "福井県",
      "19" => "山梨県",
      "20" => "長野県",
      "21" => "岐阜県",
      "22" => "静岡県",
      "23" => "愛知県",
      "24" => "三重県",
      "25" => "滋賀県",
      "26" => "京都府",
      "27" => "大阪府",
      "28" => "兵庫県",
      "29" => "奈良県",
      "30" => "和歌山県",
      "31" => "鳥取県",
      "32" => "島根県",
      "33" => "岡山県",
      "34" => "広島県",
      "35" => "山口県",
      "36" => "徳島県",
      "37" => "香川県",
      "38" => "愛媛県",
      "39" => "高知県",
      "40" => "福岡県",
      "41" => "佐賀県",
      "42" => "長崎県",
      "43" => "熊本県",
      "44" => "大分県",
      "45" => "宮崎県",
      "46" => "鹿児島県",
      "47" => "沖縄県",
    }[num]
  end

  def create_file_names
    @prefecture_name.split(" ").each_with_index.map do |prefecture, index|
      num = "%02d" % (index + 1)
      "./db/seeds/clinics/#{num}_#{prefecture}.text"
    end
  end

  def parse_url(prefecture_num)
    url_list = create_url_list(prefecture_num)
    text = []
    url_list.each do |url|
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html, nil, nil)
      (1..20).each do |n|
        string = ""
        name = doc.xpath("/html/body/div[@id='container']/div[@id='wrapper']/div[@id='main']/section[1]/div[@class='h2div'][#{n}]/h2[@class='hospitals-div-h']").text.strip
        next if name.empty?
        string += "#{name} (#{prefectures(prefecture_num)}),"

        address = doc.xpath("/html/body/div[@id='container']/div[@id='wrapper']/div[@id='main']/section[1]/div[@class='result-box cf'][#{n}]/div[@class='right-body']/div[@class='hospitals-search-list-basics']/div[@class='basicicons-address']").text.strip
        string += "#{address},"

        telphone = doc.xpath("/html/body/div[@id='container']/div[@id='wrapper']/div[@id='main']/section[1]/div[@class='result-box cf'][#{n}]/div[@class='right-body']/div[@class='hospitals-search-list-basics']/div[@class='basicicons-tel']").text.strip
        string += "#{telphone}"
        text << string
      end
      sleep 3
    end
    text
  end

  private
    def create_url_list(num)
      url_lists = []
      page_list = prefecture_clinic_page_list
      url_lists << "https://pet.caloo.jp/hospitals/search/#{num}/all/all"
      (2..page_list[num.to_i - 1]).each do |page|
        url_lists << "https://pet.caloo.jp/hospitals/search/#{num}/all/all?page=#{page}"
      end
      url_lists
    end

    def count_prefecture_page(clinic_number)
      page = clinic_number.divmod(20)
      page[0] += 1 if page[1] > 0
      page[0]
    end

    def prefecture_clinic_page_list
      @prefecture_clinic_list.scan(/\d+/).map do |num|
        count_prefecture_page(num.to_i).to_i
      end
    end
end
