# Lesson for Ansible Handson
* CentOS 7.2
* Docker Engine v1.11
* Ansible 2.1.X （注意）

## Administration tasks
* ホストの準備をする。[ホストの準備](https://github.com/tksarah/build_host)
* ホスト側の準備と同等の環境ができていれば、単体でも利用可能（ただしその場合は Playbook 実行時に ip=XXX.XXX.XXX.XXX とそのホストのIPアドレスを渡してやる）


## Preparation
* Ansibleホスト用、ターゲット用のDockerコンテナイメージが準備されている
* リバースプロキシのDockerコンテナイメージが準備されている
* roles/{lesson1,lesson2}/files/{lesson1_files,lesson2_files}/tools/setup.sh の HOSTADDR にホストのIPアドレスを入れる（ホストの準備によりPlaybookを実行した場合は自動的に入るが、本リポジトリを単体で利用する場合は Playbook 実行時に ip=XXX.XXX.XXX.XXX とそのホストのIPアドレスを渡してやる）
* roles/{lesson1,lesson2}/files/dockerfile/create_proxy.sh の HOSTADDR にホストのIPアドレスを入れる（ホストの準備によりPlaybookを実行した場合は自動的に入るが、本リポジトリを単体で利用する場合は Playbook 実行時に ip=XXX.XXX.XXX.XXX とそのホストのIPアドレスを渡してやる）

## Details of this playbook
Ansible ハンズオンを行うための以下の準備を行うPlaybook
* リバースプロキシの起動（Dockerコンテナ内と外との80ポートをつなぐ）
* ハンズオン実施ユーザを複数作成
* ユーザのホームディレクトリにハンズオン用のツールを配置
* ユーザ毎にAnsible HostとAnsible Targtのコンテナを起動

## Set User
作成するユーザのリストを host_vars/127.0.0.1 へ記載する （要 Vault パスワード）
```
group:
  - { name: 'user1' , port: '8091' }
  - { name: 'user2' , port: '8092' }
```
"group" 以外を使う場合、lesson{1,2}/tasks/main.yml の with_items のパラメータを修正する
```
      with_items:
        - "{{ group }}"
```

## Run Playbook
ユーザ毎にハンズオンできるように準備するためのPlaybookを実行

```
ansible-playbook -i hosts -e lesson=1 site.yml
```

ホストのIPアドレスを渡す場合（[ホストの準備](https://github.com/tksarah/build_host)からでなく単体で利用する場合）

```
ansible-playbook -i hosts -e "lesson=1 ip=192.168.10.10" site.yml
```
