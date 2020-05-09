# eroge_release_db [![CircleCI](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master.svg?style=svg)](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master)

美少女ゲームのブランド、ゲーム情報、出演声優、声優情報などを管理するためのデータベースです

![00_eroge_release_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/00_eroge_release_db.png)

## 概要

Master、Slave構成のRDS（PostgreSQL）内のデータベースのバージョン管理をRailsの `Active Record マイグレーション` を使用して管理します  
データベースの `設計` や `バージョン管理` を行うためのリポジトリでデータの挿入などは行いません（別のプロジェクトで行います）

## データベースER図

![eroge_release_db](https://raw.githubusercontent.com/dodonki1223/eroge_release_db/master/db/erd/eroge_release_db.png)

[Rails ERD](https://github.com/voormedia/rails-erd) を使用してデータベースのER図を出力しています

## 環境について

使用しているローカル・本番環境について説明します

### ローカル環境

ローカルの環境について説明します

#### バージョン情報

| ソフトウェアスタック | バージョン    |
|:---------------------|:-------------:|
| Rails                | 6.0.2.1以上   |
| Ruby                 | 2.6.5         |
| PostgreSQL           | 11            |
| Bundler              | 2.1.2         |

#### 開発方法

Dockerを使用して開発を行います  
PCにDockerがインストールされていれば問題ないです

### 本番環境

本番の環境について説明します  
本番環境はAWSにて構築したRDSになります  

#### バージョン情報

| ソフトウェアスタック | バージョン     |
|:---------------------|:--------------:|
| RDS(PostgreSQL)      | 11             |
| 踏み台サーバー(EC2)  | Amazon Linux 2 |

#### 本番環境へのデプロイ

GitHubのmasterブランチが更新された時、CircleCIで静的コード解析、テストが通ったらポートフォワーディングを使用してRDSに接続しRailsのマイグレーションを実行することでPostgreSQLのデータベースを更新します  

**masterブランチ以外の更新時はマイグレーションは実行されません**

## 環境構築

環境構築のために `AWS`、`CircleCI`、`Slack` の環境構築が必要です  
すごく長いので別リンクにて確認してください

### AWSの環境構築

AWSではVPC、踏み台サーバー、RDSの構築を行います

- #### [VPC構築手順書](https://github.com/dodonki1223/eroge_release_db/blob/master/documents/VPC_CONSTRUCTION.md)

![01_eroge_release_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/01_eroge_release_vpc.png)

- #### [踏み台サーバー構築手順書](https://github.com/dodonki1223/eroge_release_db/blob/master/documents/STEPPING_STONE_SERVER_CONSTRUCTION.md)

![02_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/02_stepping_stone_server.png)

- #### [RDS(Master/Slave構成)構築手順書](https://github.com/dodonki1223/eroge_release_db/blob/master/documents/DB_CONSTRUCTION.md)

![03_eroge_release_db_rds](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/03_eroge_release_db_rds.png)

### CircleCIの環境構築

CircleCIでは静的コード解析、テストを行い、成功した場合にRDSへポートフォワーディングで接続してマイグレーションを実行します  
またマイグレーションを実行するかどうか・マイグレーションの実行結果をSlackに通知する仕組みもあります

- #### [CircleCIの環境構築](https://github.com/dodonki1223/eroge_release_db/blob/master/documents/CIRCLE_CI_CONSTRUCTION.md)

![04_circleci_projects](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/04_circleci_projects.png)

### Slackの環境構築

Slackではマイグレーションを実行するかどうかの承認通知、マイグレーション完了通知を行います

- #### [Slackの環境構築](https://github.com/dodonki1223/eroge_release_db/blob/master/documents/SLACK_CONSTRUCTION.md)

**マイグレーション成功時**

![05_notify_deploy_success](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/05_notify_deploy_success.png)

**マイグレーション失敗時**

![06_notify_deploy_failure](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/06_notify_deploy_failure.png)
