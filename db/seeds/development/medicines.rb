# frozen_string_literal: true

medicines = %w(
  アイボメック
  アザニン
  アスパラカリウム
  アタラックス
  アディポリックペット
  アデルミルシャンプー
  アドナ
  アドバンテージハート
  アドバンテージプラス
  アトピカ
  アドレスタン
  アトロピン
  アピナック
  アプシード
  アミペニックス
  アルサルミン
  アンチローブ
  イベルメック
  イムラン
  インターキャット
  インターセプター
  インタードッグ
  ウェルメイトL3
  ウルソ
　エコハートチュアブル
  エースワーカー
  エチダンシャンプー
  エニシル-F
  エピスースシャンプー
  エピレス
  エンロクリア
  オティクレンズ
  オトクリーン
  オプティミューン眼軟膏
  オメガダーム
  オメガリキッド
  オラフォート
  オーレキシン
  オンシオール
  ガスター
  カニマールワンシャンプー
  カーミングリキッド
  カルチコール
  カルドメックチュアブル
  カルトロフェン・ベット
  キャナイン3
  キャナイン6Ⅱ
  キャナイン8
  キャナイン9
  キャナイン9Ⅱ
  キャナイン11
  キャニバックKC-3
  キャプスター
  キャベジン
  強力ネオミノファーゲンシー
  クランベリーU液
  グリコフレックス
  グルコリキッド
  クロミカルム
  クロルヘキシジンシャンプー
  クロロマイセチンパルミネート液
  ケフレックス
  ケラトラックスシャンプー
  コセクイン
  コバルジン
  コラージュフルフルS
  コルタバンス
  コールタールシャンプー
  コンセーブ
  コンフォティス
  コンベニア
  サーチフェクト
  サポートヘルス
  サルファサリチル酸シャンプー
  ジゴキシン
  システック
  シーパラ注
  ジルケーン
  シンクル
  シンプリセフ
  ステロップ点眼薬
  スリデン
  ゼナキル
  セボダームシャンプー
  セミントラ
  セラクイン
  セリーングリーンシャンプー
  セルベックス
  セレニア
  ゾフラン
  ソルビー
  ソル・メルコート
  ソルラクト
  ダイアップ
  タガメット注
  タケプロン
  タベジール
  ダームワン
  注射用蒸留水
  チラージンS
  ディアバスター
  デカドロン
  デポ・メドロール
  デュクソシャンプー
  デュクソラールシャンプー
  デュラミューンMX5
  デュラミューンMX6
  デュラミューンMX8
  デルクリアー
  デルモセントエッセンシャル6
  デンタルバイオ
  ドッグクララステル
  トフラニール
  トランサミン
  納豆キナーゼ
  ニゾラールシャンプー
  ネオフィリン
  ネクスガード
  ネフガード
  ノイロビタン
  ノビバックDHPPi
  ノビバックDHPPi+L
  ノビバックLEPTO
  ノビバックPUPPY DP
  ノビバックTRICAT
  ノボヘパリン
  ノルバサンサージカルスクラブ
  ノルバサンシャンプー
  バイトリル
  ハイバイトドロップス
  パセトシン
  バソトップ
  ハートメクチン
  パナメクチン錠S
  パナメクチンチュアブルP
  パノラミス錠
  バンガードプラスCPV
  バンガードプラス5/CV
  バンガードプラス5/CV-L
  ビアクタンプラス
  ビオイムバスター
  ビクタス
  ビクタスSMTクリーム
  ヒノケアシャンプー
  ヒビクス軟膏
  ヒメマツタケリキッド
  ピモベハート
  ピュアバックスRCPCh-FeLV
  ビルデンタマイシン
  ビルバゲンCRP
  ビルバゲンDA2Parvo
  ビルバゲンDA2PPi/L
  ビルバゾイルシャンプー
  フェノバール
  フィラインCPR
  フィライン6
  フィライン7
  フェロガードプラス3
  フェロセルCVR
  フェロバックス3
  フェロバックス5
  フェロバックスFIV
  フォアガルドCスポット
  フォートレオン
  フォルテコール
  プラクティック
  フラジール
  ブラベクト
  プレドニン
  プレロン
  プログラム
  ブロードライン
  プロナミド
  プロフェンダー
  プロヘパフォス
  フロントライン
  フロントラインプラス
  ペットチニック
  ベトメディン
  ヘパアクト
  ペラプリン
  ペリアクチン
  ホスティーンS
  ボミットバスター
  ホリゾン
  マイトマックス
  マイフリーガード
  マイフリーガードα
  マイラン
  マラセブシャンプー
  ミオコールスプレー
  ミサトールGV
  ミミーナ
  ミルベマイシン（薬品）
  ミルベマックス
  メタカム
  メルカゾール
  メルクメジン細粒
  モキシデック
  モキシハートタブKS
  モメタオティック
  ユーリカンP-XL
  ユーリカン5
  ユーリカン7
  ヨウ化銀錯塩
  ヨードシャンプー
  ラエンネック
  ラクツロースシロップ
  ラクトリンゲル
  ラジカルZnプラス
  ラシックス
  ラタノプロスト点眼薬
  ラピノベット
  ラリキシン
  レフトーゼ
  リプロフレックス
  リマダイル
  リレキシペット
  リュウコゲン
  流動パラフィン
  リンコシン
  リンデロンVGローション
  レベンタ
  レボリューション
  ロペラニール
  ワイドシリン
  BPO-3シャンプー
  D-フラクション
  D-smile
  PE EDTAイヤークリーナー
  PEクエン酸カリウム
  PEヘパテクト
  PEヘモテクト
  PE AHCC GCP
  RandU
  SX-フラクション
)
medicines.each do |medicine|
  Medicine.create(
    name: medicine
  )
end
