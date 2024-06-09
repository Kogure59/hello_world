# RaiseTech 課題用リポジトリ
このリポジトリは、 RaiseTech AWS フルコースの課題に取り組むために作成したリポジトリです。
## 目次
- [実践概要](##-実践概要)
- [成果物](##-成果物)
  * [AWS EC2 上での Rails アプリのデプロイ](##-AWS-EC2-上での-Rails-アプリのデプロイ)
  * [CloudFormation による自動構築](##-CloudFormation-による自動構築)
  * [CircleCI による CI/CD 環境の構築](##-CircleCI-による-CI/CD-環境の構築)
- [学習記録](##-学習記録)
  * [RaiseTechの課題](##-RaiseTechの課題)
  * [自主学習](##-自主学習)
## 実践概要
### AWS EC2 上で Ruby on Rails のサンプルアプリケーションをデプロイ 
- 組み込みサーバ ( Puma ) でデプロイ
- Web サーバ ( Nginx ) + アプリケーションサーバ ( Unicorn ) でデプロイ
- ELB ( ALB ) 、 S3 を追加
- 構築した環境の構成図を作成
### CloudFormation によるインフラ環境/リソースの構築
- テンプレートファイルを作成
- 作成したテンプレートファイルからスタックを作成
### CircleCI による CI/CD 環境の構築
  * cfn-lint を実行し、 CloudFormation のテンプレートの検証を自動化する
  * CloudFormation を実行し、環境構築を自動化する
  * Ansible を実行し、プロビジョニングを自動化する
  * ServerSpec を実行し、インフラのテストを自動化する
## 成果物
### AWS EC2 上での Rails アプリのデプロイ
詳細は [lecture05.md](lecture05.md) を参照してください。
  
構成図
### CloudFormation による自動構築
詳細は [lecture10.md](lecture10.md) を参照してください。  
CloudFormation のコードは [cloudformation](cloudformation) ディレクトリを参照してください。
### CircleCI による CI/CD 環境の構築
詳細は下記の md ファイルを参照してください。  
- [lecture11.md](lecture11.md)
- [lecture12.md](lecture12.md)
- [lecture13.md](lecture13.md)

各ツールのコードは下記のディレクトリを参照してください。
- [.circleci](.circleci)
- [cloudformation](cloudformation)
- [ansible](ansible)
- [serverspec](serverspec)
  
自動化処理がわかる図
## 学習記録
### RaiseTechの課題
#### RaiseTechの課題は以下の方針のもと進めていきます
- RaiseTech では現場と同じ依頼の粒度で課題を出す
- 原則、細かい指示はない
- 指示のない部分を考え、積極的に質問していただくことが現場でのベーススキルになる
### AWS フルコースカリキュラムと課題の概要
#### 全16回の講座を受講
1. AWS とは、インフラエンジニアとは 
    * AWS アカウントを作成
    * IAM の推奨設定 ( MFA, Billing, AdministratorAccess )
    * Amazon Linux 2 で作成した Cloud9 で Ruby を使って HelloWorld を出力
2. バージョン管理システム ( [lecture02.md](lecture02.md) )
    * GitHub でリポジトリを作成
    * Cloud9 の Git 設定変更 ( init.defaultBranch / user.name / user.email )
    * 講座の感想を Markdown で書き、プルリクエストを発行
3. Web アプリケーションとは、システム ( アプリケーション ) 開発の流れ、外部ライブラリと構成管理 ( [lecture03.md](lecture03.md) )
    * サンプルアプリケーションの起動
      + サンプルアプリケーションを GitHub からクローン
      + 添付されている README.md の理解
      + デプロイ作業 ( MySQL のインストール、 Bundler による Gem のインストール等 )
      + Web ブラウザでの接続確認
    * AP サーバー、 DB サーバーについて調べる( サーバーの名前・バージョン )
    * 課題から学んだことをまとめる
4. AWS の環境完成のイメージ、 AWS での権限管理 ( [lecture04.md](lecture04.md) )
    * AWS 上に新しく VPC を作成し、 EC2 と RDS を構築
    * EC2 から RDS へ接続し、正常であることを確認
5. EC2 にアプリケーションのデプロイ、 ELB 、 S3 、インフラ構成図 ( [lecture05.md](lecture05.md) )
    * EC2 上に第 3 回課題のサンプルアプリケーションをデプロイ
      + まずは組み込みサーバー ( puma ) だけでデプロイ
      + 動作したらサーバーアプリケーションを分けてデプロイ ( Unicorn + Nginx )
    * ELB の追加
    * S3 の追加
    * 構成図の作成
6. AWS での証跡、ロギング、監視、通知、コスト管理 ( [lecture06.md](lecture06.md) )
    * 最後に AWS を利用した日の記録を CloudTrail のイベントから探し出す
      + 自身の IAM ユーザー名があるもの
      + 見つけたイベントのイベント名と含まれている内容を 3 つピックアップ
    * CloudWatch アラームを使って、 ALB のアラームを設定して、メールを通知する
      + メールには Amazon SNS を使う
      + アラームとアクションを設定した状態で、 Rails アプリケーションが使える・使えない状態それぞれで動作を確認
7. システムにおけるセキュリティの基礎、 AWS でのセキュリティ対策 ( [lecture07.md](lecture07.md) )
    * これまでに作成した環境は、どのような攻撃に対して「脆弱」か、また、どのような対策が取れそうかを考えてまとめる
8. 構築の実演 ( 1 ) 〈※課題は無し〉
9. 構築の実演 ( 2 ) 〈※課題は無し〉
10. インフラ自動化、 CloudFormation ( [lecture10.md](lecture10.md) )
    * CloudFormation を利用して、これまでに作成した環境をコード化する
    * コード化ができたら実行して、環境が自動で作られていることを確認する
11. インフラのコード化を支援するツール、インフラのテストとは ( [lecture11.md](lecture11.md) )
    * ServerSpec のテストが成功することを確認する
      + 提供されるサンプルをカスタマイズする
      + テスト定義には決まった答えはないので、自由な発想で色々試す
12. Terraform、 DevOps 、 CI/CD ツールとは ( [lecture12.md](lecture12.md) )
    * 提供される CircleCI のサンプルコンフィグを、正しく動作するようにリポジトリに組み込む
13. Ansible 、 OpsWorks 、 CircleCI との併用 ( [lecture13.md](lecture13.md) )
    * CircleCI のサンプルに ServerSpec と Ansible の処理を追加する
14. ライブコーディング ( Ansible 〜 CircleCI )
    * これまでの AWS 構成図、自動化処理がわかる図、リポジトリの README を作る
15. ライブコーディング ( Ansible 〜 CircleCI )
    * これまでの AWS 構成図、自動化処理がわかる図、リポジトリの README を作る
16. 現場へ出ていくにあたって必要な技術と知識 〈※課題は無し〉
## 自主学習
### Windows 環境への Ansible の導入
Windows 環境で playbook の構文チェックやドライラン、デバッグを行うために、 Docker を用いて Ansible を導入しました。
- Windows に Docker for Desktop をインストール
- ローカルディレクトリに以下の Dockerfile を配置
    ```Dockerfile
    FROM amazonlinux:2
    RUN yum -y install python3 python3-pip      openssh-clients && \
        pip3 install ansible==2.9.27 pywinrm && \
        yum clean all && \
        mkdir /mydata
    ENV LANG ja_JP.UTF-8
    CMD ["/bin/bash"]
    ```
- Dockerコンテナ接続  
  * 構築するイメージのイメージ名は `my-ansible`  
  * playbookやinventoryファイルが配置される `MyData` ディレクトリを `Dockerfileを配置しているディレクトリ` 内に作成
  ```PS
    cd [Dockerfileを配置しているディレクトリ]

    docker build -t my-ansible .  #イメージ構築

    docker run -itd -v /path/to/カレントディレクトリ/MyData:/mydata my-ansible  #コンテナ実行 ( /MyData に /mydata をマウント)

    docker ps  #コンテナIDの確認

    docker exec -it [コンテナID] /bin/bash  #コンテナ接続
  ```
- マウントした /mydata に移動してファイルを作成、実行
    ```PS
    cd /mydata

    touch {playbook.yml,inventory}  #ローカルの /MyData にもファイルが作成され、変更がお互いに反映される。

    ansible-playbook playbook.yml -i inventory --syntax-check
    ansible-playbook playbook.yml -i inventory --check
    ansible-playbook playbook.yml -i inventory -vvv
    ansible-playbook playbook.yml -i inventory 
    ```
