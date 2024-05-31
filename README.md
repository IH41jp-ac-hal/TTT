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
git clone "https://github.com/IH41jp-ac-hal/Flutter_App.git"
```
## ブランチを切る

// ディレクトリの階層を以下のように降りてください。
```
cd .\Flutter_App\exampletest\
```
// ここで、mainが表示されるか確認してください。
```
git branch
```
// Developブランチを切ってください。
※ローカル環境とリモート環境を統合させます。
```
git switch -c develop
git pull origin develop
```
// \Flutter_App\配下にあるReadmeファイルの変更をステージングエリアに保存します。
```
cd ..
git add .
git commit -m "firstcommit"
cd exampletest
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
git push origin develop
```
// プルリクエストを投げましょう。※一旦無視でok

ここからは、GitHubの組織をブラウザで立ち上げてください。
先ほど、PUSHした内容がプルリクエスト出来るようになっています。
自分のブランチからDevelopブランチに対してプルリクエストを投げるようにしてください。





