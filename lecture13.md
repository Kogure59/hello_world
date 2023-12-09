# 第13回課題
#### CircleCI のサンプルに ServerSpec や Ansible の処理を追加してください。
Ansible はいきなりやりたいことを実装するのではなく、最低限の「必ず成功する Playbook」を用意して徐々に仕事を追加しましょう。
## 実施内容
### CircleCIの実行
ServerSpec や Ansible の処理を追加するにあたって、まず Ansible の playbook を role で分割してそれぞれのタスクをドライランさせて検証を行いました。今回の課題では、rails を動かすために必要なパッケージを yum モジュールでインストールするタスクまでを実行し、それ以外のアプリデプロイまでのタスクの実行は課題外で挑戦したいと思います。
- cfn-lint: CloudFormation テンプレートの検証 [.circleci/config.yml](.circleci/config.yml)
- execute-cfn: CloudFormation で環境構築 [cloudformation/](cloudformation/)
- excute-ansible: Ansible でプロビジョニング [asnible/](ansible/)
- execute-serverspec: ServerSpec でテスト [serverspec/](serverspec/)
#### 実行結果
- cfn-lint
![Alt text](images_lec13/lecture13/cfn_lint_lec13.png)  

- execute-cfn
![Alt text](images_lec13/lecture13/execute_cfn_lec13.png)  

- execute-ansible
![Alt text](images_lec13/lecture13/execute_ansible_lec13.png)
![Alt text](images_lec13/lecture13/execute_ansible_lec13_2.png)  

- execute-serverspec
![Alt text](images_lec13/lecture13/execute_serverspec_lec13.png)
![Alt text](images_lec13/lecture13/execute_serverspec_lec13_2.png)
#### Workflow Pipeline
![Alt text](images_lec13/lecture13/workflow_pipeline_lec13.png)
---
### Windows に circleci-cli をインストール
CircleCI 公式の推奨通り Chocolatey を用いてインストールした。PowerShellを管理者権限で開いて chocolatey をインストールし、その後 choco コマンドで circleci-cli をインストールした。
```PS
# セキュリティポリシーの一時的な変更とTLS 1.2 の有効化を行い、Chocolateyのインストールスクリプトをダウンロードして実行
PS C:\Windows\system32> Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

PS C:\Windows\system32> choco install circleci-cli -y
```

---
### ローカルでAnsibleを試行
playbookの構文チェックやドライラン、デバッグを行うためにWindows環境にAnsibleを導入した。
- Windows に Docker for Desktop をインストール
- ローカルディレクトリに Dockerfile を配置
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
  * 構築するイメージのイメージ名を `my-ansible` とした。  
  * playbookやinventoryファイルが配置される `MyData` ディレクトリを `Dockerfileを配置しているディレクトリ` 内に作成した。
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
## 苦労した点
- Ansible のドライラン実行時の `Cannot find a valid baseurl for repo: amzn2-core/2/x86_64` というエラーの原因がいくつか考えられ、可能性が高いと思われる方法でも解決されなかったため、除外していた原因を再度細かく確認したところ、EC2(ターゲットノード)のアウトバウンドルールで**すべてのトラフィック**を許可するべきところを誤って**すべてのICMP-IPv4**を許可していました...  
ネットワーク接続に問題がある可能性を、「 Docker は SSH 接続できているからネットワーク接続は大丈夫だろう」という判断でその問題を除外してしまっていたことが大きな間違いでした。

- CircleCI で Ansible 初実行時に unreachable の結果が出ました。Ansible 関連のファイルやホスト先の EC2 インスタンスのセキュリティグループに誤りが見られなかったため、EC2 がプライベートサブネットに関連付けされていることが可能性として高くなりました。結局、パブリックサブネットの Value での参照リソースがプライベートサブネットになってエクスポートされていて、それを EC2 インスタンスリソースの設定でインポートしてしまったことが原因でした。これを解決するために、問題のあるスタックを削除して再作成しました。

このような初歩的なミスで後々面倒な訂正をする必要があることを身をもって経験しました。設定を施す前に一つ一つ確認することが大切だと実感しました。
## 参考
- [Windows10 に ゼロから Ansible をインストールする](https://qiita.com/Tkm08/items/58e1fb7990387a2e9c76)
- [WindowsにCircleCI コマンドをインストール](https://net-newbie.com/2020/08/29/install-circleci-on-windows/)
- [CircleCI Developer - Orbs](https://circleci.com/developer/ja/orbs)
- [Ansible - ディレクトリ構成について](https://qiita.com/makaaso-tech/items/0375081c1600b312e8b0)
- [Ansible community documentation](https://docs.ansible.com/)