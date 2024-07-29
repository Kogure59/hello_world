# 第6回課題

### 最後に AWS を利用した日の記録
CloudTrail イベントから探し出す  (自身の IAM ユーザー名があるもの )
  - イベント名  : RebootInstances
  - 含まれている内容3 つをピックアップ
    * "eventTime": "2023-09-08T14:28:28Z",
    * "eventSource": "ec2.amazonaws.com",
    * "eventName": "RebootInstances",

  EC2 インスタンスを再起動させたイベントが記録されている。イベントの時間や名前、ソースなどイベントに関する情報のほか、 EC2 に設定されている IAM ユーザーのアカウントに関する情報が記録されている。

### CloudWatch アラームを使って、ALB のアラームを設定して、メール通知してみる

- Unicornが停止している状態
![Alt text](/images/images_lec06/lecture06/CloudWatch_unhealthy_unicorn_stop.png)

  通知メール
  ![Alt text](/images/images_lec06/lecture06/CloudWatch_unhealthy_unicorn_stop_Email.png)

- Unicornを起動した状態
![Alt text](/images/images_lec06/lecture06/CloudWatch_unhealthy_unicorn_restart.png)

  通知メール
  ![Alt text](/images/images_lec06/lecture06/CloudWatch_unhealthy_unicorn_restart_Email.png)

### AWS 利用料の見積を作成
Pricing Calculater でリソース利用料の見積りを作成した。

[見積へのリンク](https://calculator.aws/#/estimate?id=dc03b7aab8001e6cac7c3b0d6d7202301e4fbcad)

### マネジメントコンソールから、現在の利用料を確認
先月の請求と EC2 の料金

![Alt text](/images/images_lec06/lecture06/billing_last_month_1.png)
![Alt text](/images/images_lec06/lecture06/billing_last_month_2.png)

- 使っていない EC2 インスタンスにアタッチされたボリュームがあり、使用中のものと合わせて無料利用枠を超えていた。
- 今月そのコストを発生させないために不要な EC2 インスタンスを削除し、アタッチされたボリュームを削除した。