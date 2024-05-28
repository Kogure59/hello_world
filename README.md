# RaiseTech 課題用リポジトリ
このリポジトリは、 RaiseTech AWS フルコースの課題を記録したリポジトリです。
## 目次
- インフラ環境構築・ CI/CD 環境構築
  * [AWS EC2 上で Ruby on Rails のサンプルアプリケーションをデプロイ ( 手動構築 )](##-AWS-EC2-上で-Ruby-on-Rails-のサンプルアプリケーションをデプロイ)
  * [CloudFormation によるインフラ環境/リソースの構築](##-CloudFormation-によるインフラ環境/リソースの構築) 
  * [CircleCI による CI/CD 環境の構築](##-CircleCI-による-CI/CD-環境の構築)

- 学習記録
  * [RaiseTechの課題](##-RaiseTechの課題)
  * [自主学習](##-自主学習)
## AWS EC2 上で Ruby on Rails のサンプルアプリケーションをデプロイ 
### 実践内容
- 組み込みサーバ ( Puma ) でデプロイ
- Web サーバ ( Nginx ) + アプリケーションサーバ ( Unicorn ) でデプロイ
- ELB ( ALB ) , S3 を追加
- 構築した環境の構成図を作成
## CloudFormation によるインフラ環境/リソースの構築
### 実践内容
- テンプレートファイルを作成
- 作成したテンプレートファイルからスタックを作成
## CircleCI による CI/CD 環境の構築
## RaiseTechの課題
### RaiseTechの課題は以下の方針のもと進めていきます
- RaiseTech では現場と同じ依頼の粒度で課題を出す
- 原則、細かい指示はない
- 指示のない部分を考え、積極的に質問していただくことが現場でのベーススキルになる
### AWS フルコースカリキュラムと課題概要
#### 全16回の講座を受講
1. AWS とは  
    * AWS アカウントを作成
    * IAM の推奨設定 ( MFA, Billing, AdministratorAccess )
    * Amazon Linux 2 で作成した Cloud9 で Ruby を使って HelloWorld を出力
2. バージョン管理システム
    * GitHub でリポジトリを作成
    * Cloud9 の Git 設定変更 ( init.defaultBranch / user.name / user.email )
    * 講座の感想を Markdown で書き、プルリクエストを発行
## 自主学習