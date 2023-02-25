#!/bin/bash

# Git PULL
cd /home/isucon/isucari/webapp
git checkout main
git pull origin main

# goビルド
cd /home/isucon/isucari/webapp/go
./../../../local/go/bin/go build

# ハードリンク貼り直し
sudo rm -f /etc/mysql/mysql.conf.d/mysqld.cnf
cd /etc/mysql/mysql.conf.d
sudo ln /home/isucon/isucari/webapp/configs/mysqld.cnf

# サービス再起動
sudo systemctl restart nginx
sudo systemctl restart mysql
sudo systemctl restart isucari.golang

# ログクリア
sudo truncate /var/log/mysql/mysql-slow.log --size 0
sudo truncate /var/log/nginx/access.log --size 0
