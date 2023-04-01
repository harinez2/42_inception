# 42_inception

Wordpress、Nginx、MariaDBの各コンテナをDocker composeで起動できます。

# Features

- 各コンテナはインストール手順をスクリプトで記述しており、カスタマイズが可能です。
- 各サービスがそれぞれ1つのコンテナとなっており、サービスの追加等拡張性があります。
- NginxとMariaDBはaptで、WordpressはWP-CLIを用いてインストールします。
 
# Requirement
 
* Docker
* Docker compose

### 動作確認環境(1)

```bash
$ uname -a
Linux <hostname> 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

$ sudo docker -v
Docker version 20.10.22, build 3a2c30b

$ sudo docker compose version
Docker Compose version v2.14.1
```

### 動作確認環境(2)

```bash
~ uname -a
Linux salty-VirtualBox 5.4.0-146-generic #163~18.04.1-Ubuntu SMP Mon Mar 20 15:02:59 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

~ sudo docker -v
Docker version 20.10.21, build 20.10.21-0ubuntu1~18.04.2

~ sudo docker compose version
Docker Compose version v2.17.2
```

# Pre-requirements

## nginxサービスを停止
動作確認等での混乱を避けるため、不要であればホスト側のNginxは停止します。

```bash
sudo service nginx stop
```

## hostsへドメインを追加

コンテナにホスト名で接続する場合、ホスト名をhostsに追加しておきます。

- ipコマンドでIPアドレスを調べます。
    
    ```bash
    $ ip -4 a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
    2: <<省略>>
    3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
        inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
           valid_lft forever preferred_lft forever
    80: <<省略>>
    ```
    
    上記のdocker0に割り当たっている「172.17.0.1」をメモ
    

- hostsファイルに書き込み
    
    hostsを開く
    
    ```bash
    sudo vi /etc/hosts
    ```
    
    以下の行を追加（IPはさっきメモったもの）
    
    ```bash
    172.17.0.1    yonishi.42.fr
    ```
    

## ディレクトリ作成

インストールされたWordpressデータ、MariaDBのデータベース格納先としてディレクトリを作成します。
ホスト側にデータが保持されます。

```bash
sudo mkdir -p /home/yonishi/data/wordpress
sudo mkdir -p /home/yonishi/data/mariadb

```

## docker login

```bash
sudo docker login
```

# Installation
 
```bash
git clone https://github.com/hoge/~
cd 42_inception
make
```
 
### Makefileのルール

```
# compose up
make
make all
make up

# compose down
make down
make clean

# start/stop
make start
make stop

# show ps
make ps

# prune
make prune
make fclean

# prune including system build cache
make sysprune
```

# Usage

## ブラウザからのアクセス

## Firefoxの例
- https://yonishi.42.fr/

自己証明書のため警告が出ます。Advanced → Accept the Risk and Continue を選んでください。

## curl

```
curl https://yonishi.42.fr/ -k
```

# Note
 
- 設定は.envに記載する
 
# Author

* yonishi
* yonishi@student.42tokyo.jp
 
# License
 
"42_inception" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
