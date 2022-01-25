![MediPet_logo](https://user-images.githubusercontent.com/64201542/150978289-5e8c7f46-7f91-41d8-b7ee-3bb9a77d99fe.png)

# MediPet
ペットのお薬手帳というサービスは、
問題が起きないように獣医を変えた時に以前の薬の情報を提供したい、
よく獣医に行く人向けの、記録サービスです。

## 機能概要
病院と薬の名前を選択するだけで簡単に登録できます。

以前登録したデータをコピーできるので同じ薬を貰った時の入力は楽にできます。

## ローカルでの立ち上げ方
```
$ bin/setup
$ rails s
```

## seed(テストデータ)
*病院情報の作成に数分かかります
```
$ rails db:seed
```

## テスト・Lint
```
$ bin/lint
$ bundle exec rspec
```
