# 第4回課題

## 課題内容
- AWS上に新しくVPCを作成
- EC2インスタンスを作成
- RDSを作成
- EC2からRDSへ接続し、正常であることを確認

### AWS上に新しくVPCを作成
![VPC](/images/images_lec04/new_vpc_lecture04.png)

### EC2インスタンスを作成
![EC2](/images/images_lec04/created_ec2_lecture04.png)
![EC2_SG](/images/images_lec04/ec2_security_group_lecture04_v2.png)

### RDSを作成
![RDS](/images/images_lec04/created_rds_lecture04.png)
![RDS_SG](/images/images_lec04/rds_security_group_lecture04_v2.png)
![RDS_SubnetG](/images/images_lec04/rds_subnet_group_lecture04.png)

### EC2からRDSへ接続し、正常であることを確認
- Tera Termで、作成したEC2インスタンスにSSH接続
- RDSへ接続
![CONNECTION](/images/images_lec04/connect_to_rds_from_ec2.png)

## 今回の課題から学んだこと
- 無料利用枠内でのAWS環境構築の方法
- ローカルからEC2インスタンスへのSSH接続の方法(今回はTera Termを使用)
  * TCP/IP ホスト: <EC2のパブリックIPv4アドレス>
  * SSH認証 ユーザー名: ec2-user, 秘密鍵: <EC2作成時に作成したキーペア(.pemファイル)>
- EC2からRDSへの接続方法
  * mysql -h <RDSのエンドポイント> -u <RDSのマスターユーザー名> -p
  * Enter password: <RDS作成時のパスワード>
- AWS上のネットワークの環境構築は簡単にできてしまうが、各設定の意味・役割などをしっかりと把握し、ネットワークの構成を脳内でイメージできるようにすることが大切
