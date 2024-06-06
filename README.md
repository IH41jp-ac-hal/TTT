# TruckerTrekker開発プロジェクト
# 使用技術
・Flutter (Dart)

・Firebase
# 開発環境構築
## 事前準備
下記のURLからgit bashをインストールしてください。

https://git-scm.com/
### Gitの初期設定
ここでは、ごく最低限の設定だけを行います。

// ユーザー名を設定する
```
$ git config --global user.name "you-name"
```
// メールアドレスを設定する
```
$ git config --global user.email "you-email@example.com"
```
※GitHubで登録されたユーザー名とメールアドレスを入力してください。
## リポジトリをcloneする
`C:\IH41jp-ac-hal`上でpowershellを立ち上げ、リモートリポジトリをcloneしてください。
```
git clone "https://github.com/IH41jp-ac-hal/TTT.git"
```
## ブランチを切る

// ここで、mainが表示されるか確認してください。
```
cd .\TTT\
git branch
```
// Developブランチを切ってください。
※ローカル環境とリモート環境を統合させます。
```
git switch -c develop
git pull origin develop
```
// ステージングエリアに保存します。
```
git add .
git commit -m "firstcommit"
```
// ここから、自分の作業環境を構築していきます。
※nameは仮で自分の名前にしておいてください。
```
git switch -c feature/name
git push origin feature/name
```
## 基本操作

// Developブランチをフェッチしましょう。（Developブランチに変更が無い場合は、意味を成しませんが適宜に行いましょう。）
```
git pull origin develop
```
// コミットしたいファイルを登録しましょう。
```
git add .
```
// ファイルを更新しましょう。
```
git commit -m "修正内容"
```
// ローカルリポジトリの内容をリモートリポジトリに送信して下さい。
```
git push origin "ブランチ名"
```

## プルリクエストを投げる

// プルリクエストを投げましょう。

ここからは、GitHubの組織をブラウザで立ち上げてください。
先ほど、PUSHした内容がプルリクエスト出来るようになっています。
自分のブランチからDevelopブランチに対してプルリクエストを投げるようにしてください。

1-GitHubのリポジトリ開きましょう。

2-画面上部のタブからPull requestsを選択してください。

3-画面右側の緑色のNew pull requestを選択してください。

4-画面右側の緑色のCreate pull requestを選択してください。

下記のスクリーンショットの1枚目と2枚目は画面が切り替わった時のイメージです。

1-/2-/3-/

![スクリーンショット (25)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/bdad7f23-1292-4eeb-978a-215b0af3d642)

4-/

![スクリーンショット (27)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/9043cc9d-526d-4870-b377-6c2b9f6a2358)

## Git操作豆知識

// ブランチ切り替え方

```
git switch "ブランチ名"
```

// ローカルブランチ削除

Gitでは現在のブランチを削除することできません。そのため、削除対象外のブランチに切り替える必要があります。

```
git switch main
git brach -d "ブランチ名"
```

// ブランチ名変更

1.0-リモート上の操作

1.1-View all branchesを開いてください。

1.2-名前変更したいブランチ画面右側の◦◦◦を選択しRename branchを選択してください。

1.3-ブランチ名を決めたら緑色のRename branchを選択しましょう。

1-/
![スクリーンショット (28)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/462f0669-3e5b-47f3-8697-206e36e73ce3)
2-/
![スクリーンショット (29)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/89aaac53-1302-45dd-863e-85a8c5a04cc1)
3-/
![スクリーンショット (30)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/200d8bf5-576b-441c-bce9-8002244bad5c)

2.0-ローカル上の操作

2.1-
```
git branch -m OLD-BRANCH-NAME NEW-BRANCH-NAME
git fetch origin
git branch -u origin/NEW-BRANCH-NAME NEW-BRANCH-NAME
git remote set-head origin -a
```

※必ず上記の手順で行ってください。




