# 第13回課題
#### CircleCI のサンプルに ServerSpec や Ansible の処理を追加してください。
Ansible はいきなりやりたいことを実装するのではなく、最低限の「必ず成功する Playbook」を用意して徐々に仕事を追加しましょう。
## 実施内容
### ローカルでAnsibleを実行
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
    ```
    cd [Dockerfileを配置しているディレクトリ]

    docker build -t my-ansible .  #イメージ構築

    docker run -itd -v /カレントディレクトリ/MyData:/mydata my-ansible  #コンテナ実行 ( /MyData に /mydata をマウント)

    docker ps  #コンテナIDの確認

    docker exec -it [コンテナID] /bin/bash  #コンテナ接続
    ```
- マウントした /mydata に移動してファイルを作成、実行
    ```
    cd /mydata

    touch {playbook.yml,inventory}  #ローカルの /MyData にもファイルが作成され、変更がお互いに反映される。

    ansible-playbook playbook.yml -i inventory --syntax-check
    ansible-playbook playbook.yml -i inventory --check
    ansible-playbook playbook.yml -i inventory -vvv
    ansible-playbook playbook.yml -i inventory 
    ```
### CircleCIの実行
- cfn-lint

- execute-cfn

- execute-ansible

- execute-serverspec

---
### 参考
- [Windows10 に ゼロから Ansible をインストールする](https://qiita.com/Tkm08/items/58e1fb7990387a2e9c76)
- [Ansible community documentation](https://docs.ansible.com/)