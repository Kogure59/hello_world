# 第7回課題
第7回講義で特に覚えておくべき基本的なところについての要点をまとめ、自分が作っている環境の脆弱性とそれへの対策を考えた。

---
### システムにおけるセキュリティの基礎
- システムが正常に稼働し続けるためには、インフラの正常性確認のほか、**セキュリティ**についても意識する必要がある。
- **セキュリティリスクへの理解**と、**リスク対策を決めておくこと**が必要である。
- セキュリティの**基本原則**
  * **想定されるリスクを洗い出す**
  * リスクに対しての**対応方針（アクション）を定義する**
    + **受容** : そのまま受け入れる。何も対策は行わない。
    + **低減** : 影響を減らすような対策を行う。
    + **移転(転嫁)** : そもそものリスク管理を当事者以外に任せる。
    + **回避** : リスク自体を発生させないようにする。
- 想定されるリスクとは  
主にデータの盗難、改ざん、破壊であり、その要因は以下の3つ。
  * **脆弱性** : バグや設定不備によるシステムの「弱点、穴」。 log4j2 問題という事例がある。
  * **認証情報の流出** : 誤って GitHub など公開の場にアップロードした情報を収集している攻撃者が、その情報でログインを試みる。IAM アクセスキーの流出は定期的に発生している。
  * **人為的な過負荷** : 多数のコンピュータから連続でリクエストを送り、停止に追いやる。DDoS 攻撃が有名。  
   
### セキュリティ対策計画の主体は誰が適切？
セキュリティ対策計画の主体はエンジニアではなく、事業責任者であり、エンジニアは専門家としての知見を提供する立場であるべき。しかしこれはあくまで理想であるため、**基本的には「すべてのリスクを洗い出すのは不可能（増えるものだから）」「最終判断は事業責任者ですよ」という相手へのインプット、合意は忘れないようにする。**

---
### 第5回課題までに構築した環境は、どんな攻撃にたいして「脆弱」か、どのような対策が取れそうか

![Alt text](images_lec05/lecture05/lecture05_%E6%A7%8B%E6%88%90%E5%9B%B3_2.png)

#### 現在の設定されているセキュリティ
- ELB へのアクセスはマイ IP からのみ許可している。
- EC2 はマイ IP ( SSH接続 ) と ELB のセキュリティグループ からのアクセスを許可している。
- RDS はプライベートサブネットに配置し、EC2 のセキュリティグループからのみアクセスを許可している。
- S3 は全てのパブリックアクセスをブロックしている。
- IAM ユーザーのログインには多要素認証MFAが必要。ワンタイムKey は別端末の Authenticator アプリで管理している。

#### 現在の環境における脆弱性と対策
- アプリ自身に脆弱性対策のツールが備わっていない。  
→ **AWS WAF** で、 AWS やパートナーが提供するルールセットを ELB に設定する。
- アプリは HTTP 通信であるため、盗聴や改ざん、情報漏洩などの脅威に晒される可能性がある。  
→ **AWS Certificate Manager（ACM）** で SSL 証明書を発行して、SSL 通信 を用いる。
- コード入力の際にハードコーディングしている可能性があるため、情報漏洩の脅威に晒される可能性がある。 
→ **CodeGuru Reviewer** でコードにある保護されていない認証情報をスキャンし、検出された場合は認証情報を **Secrets Manager** に移行し、アプリが提案した通りに修正しテストする。
---
### 感想
AWS でのセキュリティ対策は、無料で行えるサービスもある。しかし、重要な情報を扱ったり、大規模な開発をする際は、リスクによって多大な損失が生じることを考えたら、多少料金がかかってでも充実したサービスを扱い、想定されるリスクとその要因を対策することが重要だと思った。  
セキュリティの管理は Developer と User などそれぞれが求めるものが異なることがあると思うので、その要件に適する ”リスクに対応するアクション” を行える能力を磨くことが重要だと思った。  
今回は特に 脆弱性 について考えたが、 認証情報の流出 や 人為的な過負荷 についても考えていきたい。