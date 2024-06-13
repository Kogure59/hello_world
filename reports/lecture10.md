# 第10回課題
## CloudFormation を利用して、現在までに作った環境をコード化する
- CloudFormation では YAML 形式のテンプレートファイルを読み込むことで スタックという 1 つの単位で環境が構築される。
- スタック作成中にエラーが起こると、作成途中のリソースが全削除される。
- エラーになったスタック自体はエラー内容確認後、手動で削除する。
### 事前準備
1. Python ( pip ) と cfn-lint をインストール
2. VSCode でプラグインの CloudFormation ( スニペットとして使う ) と CloudFormation Linter をインストール
3. settings.json に yaml.customTags の設定を追記
4. Cfn Lint: Path を /usr/local/bin/cfn-lint と設定する
### 環境構築
1. VPC, セキュリティグループ, EC2, ALB, RDS, S3 で**分けてテンプレートファイルを作成**
2. VPC, セキュリティグループ, EC2, ALB, RDS, S3 の順にスタックを作成
![Alt text](images_lec10/lecture10/stacks_lec10.png)
- テンプレートファイルを分けて作成しているため、 !ImportValue "論理 ID" を使用して別のテンプレートから値をインポートした。また、そのためにエクスポート元の Outputs で出力した。  

- ターゲットグループの設定でターゲットとする EC2 を呼び出すために ALB の前に EC2 を構築する必要があるが、 EC2 のセキュリティグループのインバウンドルールで ALB のグループ ID をソースとするため、各リソースのセキュリティグループを 1 つのテンプレートファイルにまとめて作成して EC2 の前に構築するようにした。  

- IAM ロール で S3 にアクセスするため EC2 に IAM ロールを作成した。  

- セキュリティグループのプロパティ内に Ingress rule を記入すると自己参照になる。  
→ AWS::EC2::SecurityGroupIngress に外だし  
→  自己参照や循環参照がなくなり、リソースの依存関係も適切に処理されて、CloudFormationスタックの問題が起きなくなる。
  
### 構築された環境 
- VPC
![Alt text](images_lec10/lecture10/vpc_lec10.png)
- サブネット
![Alt text](images_lec10/lecture10/publicSubnet_1a_lec10.png)
![Alt text](images_lec10/lecture10/publicSubnet_1c_lec10.png)
![Alt text](images_lec10/lecture10/privateSubnet_1a_lec10.png)
![Alt text](images_lec10/lecture10/privateSubnet_1c_lec10.png)
- セキュリティグループ
![Alt text](images_lec10/lecture10/secGroup_alb_inbound_lec10.png)
![Alt text](images_lec10/lecture10/secGroup_alb_outbound_lec10.png)
![Alt text](images_lec10/lecture10/secGroup_ec2_inbound_lec10_v2.png)
![Alt text](images_lec10/lecture10/secGroup_ec2_outbound_lec10.png)
![Alt text](images_lec10/lecture10/secGroup_rds_inbound_lec10.png)
![Alt text](images_lec10/lecture10/secGroup_rds_outbound_lec10.png)
- EC2
![Alt text](images_lec10/lecture10/ec2_lec10.png)
- IAM ロール
![Alt text](images_lec10/lecture10/iamRole_lec10.png)
- ALB
![Alt text](images_lec10/lecture10/alb_lec10.png)
![Alt text](images_lec10/lecture10/alb_mapping_lec10.png)
- ターゲットグループ
![Alt text](images_lec10/lecture10/targetGroup_lec10.png)
- RDS
![Alt text](images_lec10/lecture10/rds_lec10.png)
![Alt text](images_lec10/lecture10/rds_property_lec10.png)
- S3
![Alt text](images_lec10/lecture10/s3Bucket_lec10.png)
![Alt text](images_lec10/lecture10/s3Bucket_policy_lec10.png)
### 参考文献
- [CloudFormation のための VSCode 環境作成](https://coffee-nominagara.com/cloudformation-vscode-plugins)
- [セキュリティグループからの通信許可はAWS::EC2::SecurityGroupIngressに書く](https://qiita.com/tsukamoto/items/b37975f7e6db6ee8e4dd)
- [組み込み関数リファレンス](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)
- [AWS CloudFormationでEC2を構築](https://qiita.com/tyoshitake/items/c5176c0ef4de8d7cf5d8)
- [IPアドレス(IPv4)の正規表現](https://www.javadrive.jp/regex-basic/sample/index4.html)