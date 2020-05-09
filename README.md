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
