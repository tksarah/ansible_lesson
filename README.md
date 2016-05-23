# Lesson1 for Ansible Handson
* CentOS 7.2
* Docker Engine v1.11
* Ansible 2.0.1

## Administration tasks
まず、ホストの準備をする。（未記載,これもPlaybook用意）

## Preparation
* Ansibleホスト用、ターゲット用のDockerコンテナイメージが準備されている
* リバースプロキシのDockerコンテナイメージが準備されている
* このリポジトリを clone した後、lesson1_files/tools/setup.sh の HOSTADDR にホストのIPアドレスを入れる

## Details of this playbook 
Ansible ハンズオンを行うための以下の準備を行うPlaybook
* リバースプロキシの起動（Dockerコンテナ内と外との80ポートをつなぐ）
* ハンズオン実施ユーザを複数作成
* ユーザのホームディレクトリにハンズオン用のツールを配置
* ユーザ毎にAnsible HostとAnsible Targtのコンテナを起動
 
## Run Playbook
作成するユーザのリストを vars/userlist.yml き記載する
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
ansible-playbook -i hosts main.yml
```
