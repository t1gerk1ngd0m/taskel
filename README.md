# README

# 本番環境
https://taskel.herokuapp.com/

## テスト用ログインユーザー情報
ID: ttttt@yahoo.com
password: 123456

# アプリ作成の目的
このアプリはmofmof社での研修課題として作成したものです。
このアプリの作成を通して環境構築、Ruby on Railsの基本的操作、Gitの使い方、テスト、Heroku/AWSへのデプロイなどアプリケーション作成における一連の流れを学習しています。

# ER図
https://cacoo.com/diagrams/DUr0oE7vGEijWxpf/F0747

# アプリ機能
タスク管理アプリ

# DB構造
画像に記載の通り

# デプロイ方法
ターミナル上で下記のコマンドを実行  
` git push heroku master `  
下記のコマンドを実行し本番環境を確認  
` heroku open `  
本番環境でエラー発生時は下記コマンドで確認  
` heroku logs `  

# フレームワークバージョン
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin18]  
Rails 5.2.3  
