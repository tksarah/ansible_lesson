# Lesson for Ansible Handson
* CentOS 7.2
* Docker Engine v1.11
* Ansible 2.1.X （注意）

## Administration tasks
まず、ホストの準備をする。[ホストの準備](https://github.com/tksarah/build_host)

## Preparation
* Ansibleホスト用、ターゲット用のDockerコンテナイメージが準備されている
* リバースプロキシのDockerコンテナイメージが準備されている
* roles/{lesson1,lesson2}/files/{lesson1_files,lesson2_files}/tools/setup.sh の HOSTADDR にホストのIPアドレスを入れる（ホストの準備によりPlaybookを実行した場合は自動的に入る）

## Details of this playbook
Ansible ハンズオンを行うための以下の準備を行うPlaybook
* リバースプロキシの起動（Dockerコンテナ内と外との80ポートをつなぐ）
* ハンズオン実施ユーザを複数作成
* ユーザのホームディレクトリにハンズオン用のツールを配置
* ユーザ毎にAnsible HostとAnsible Targtのコンテナを起動

## Run Playbook
作成するユーザのリストを roles/{lesson1,lesson2}/vars/userlist.yml き記載する
```
group1: [ 'user1' , 'user2' , 'user3' ]
group2: [ 'user4' , 'user5' , 'user6' ]
```
main.yml の with_items のパラメータを修正する
```
      with_items:
        - "{{ group1 }}"
```
ユーザ毎にハンズオンできるように準備するためのPlaybookを実行

```
ansible-playbook -i hosts -e lesson=1 main.yml
