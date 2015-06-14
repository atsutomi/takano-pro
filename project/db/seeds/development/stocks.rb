# coding: utf-8

nums = %w(2379 3667 6218 6250 2222 3769 2326 3385 3067 8255 7408 7244 3393 5218 6121 6958 3526 6905 2168 1964 8056 3770 6479 6929 2301 7732 7976 7447 7897 5351 6463 7885 8698 6103 3762 3660 8150 8920 4641 6678 3194 9719 8750 9828 9543 6630 2427 4917 6981 9957)
names = ["ディップ(株)", "(株)ｅｎｉｓｈ", "エンシュウ(株)", "(株)やまびこ", "寿スピリッツ(株)", "ＧＭＯペイメントゲートウェイ(株)", "デジタルアーツ(株)", "(株)薬王堂", "(株)東京一番フーズ", "アクシアル　リテイリング(株)", "(株)ジャムコ", "市光工業(株)", "スターティア(株)", "(株)オハラ", "(株)滝澤鉄工所", "日本ＣＭＫ(株)", "芦森工業(株)", "コーセル(株)", "(株)パソナグループ", "中外炉工業(株)", "日本ユニシス(株)", "(株)ザッパラス", "ミネベア(株)", "日本セラミック(株)", "(株)学情", "(株)トプコン", "三菱鉛筆(株)", "ナガイレーベン(株)", "ホクシン(株)", "品川リフラクトリーズ(株)", "ＴＰＲ(株)", "タカノ(株)", "マネックスグループ(株)", "オークマ(株)", "テクマトリックス(株)", "(株)アイスタイル", "三信電気(株)", "(株)東祥", "(株)アルプス技研", "(株)テクノメディカ", "(株)キリン堂ホールディングス", "ＳＣＳＫ(株)", "第一生命保険(株)", "元気寿司(株)", "静岡ガス(株)", "ヤーマン(株)", "(株)アウトソーシング", "(株)マンダム", "(株)村田製作所", "(株)バイテック"]
prices = %w(11560 2062 129 5470 2960 3615 1540 3635 644 3285 3925 327 1692 644 255 337 226 1589 1055 295 1186 645 2222 1786 1419 2821 6070 2408 166 307 3905 838 364 1450 922 1011 1279 2642 2516 3025 1285 3595 2368.5 2463 892 1630 1953 5610 19915 1404)

0.upto(49) do |idx|
  Stock.create(
    num: nums[idx],
    market: "東証1部",
    name: names[idx],
    price: prices[idx],
    date: "2015-06-12"
  )
end