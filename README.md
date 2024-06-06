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
// プルリクエストを投げましょう。※一旦無視でok

ここからは、GitHubの組織をブラウザで立ち上げてください。
先ほど、PUSHした内容がプルリクエスト出来るようになっています。
自分のブランチからDevelopブランチに対してプルリクエストを投げるようにしてください。

![スクリーンショット (25)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/bdad7f23-1292-4eeb-978a-215b0af3d642)
![スクリーンショット (27)](https://github.com/IH41jp-ac-hal/TTT/assets/109325206/9043cc9d-526d-4870-b377-6c2b9f6a2358)

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





