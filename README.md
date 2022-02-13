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

AWSの環境構築にはUdemy の `手を動かしながら2週間で学ぶ AWS 基本から応用まで` の教材をすごく参考にさせて頂きました  
現在は受講出来ないようなので作者のブログ記事の [AWS学習の0→1をサポートする講座「手を動かしながら2週間で学ぶ AWS 基本から応用まで」をUdemyでリリースしました - log4ketancho](https://www.ketancho.net/entry/2018/09/03/074115) を確認してください

現在はコンソール画面で作成せずに **Terraform 化されているため、基本的には Terraform で作成することをオススメします！**

#### Terraform 環境構築

Terraform 化されたため、 Terraform の tfstate ファイルを管理させる S3 を作成します  
tfstate を管理させるバケットとバケット作成コマンドを実行する profile 名を指定して実行させます

```shell
$ bash bin/init_s3.sh

tfstateを格納するS3バケット名を入力して下さい: eroge-release-db
S3バケット作成で使用するprofile名を入力してください: terraform
eroge-release-dbの作成を行います
eroge-release-dbにバージョンニングを有効化に成功しました
eroge-release-dbにサーバー側の暗号化を有効化に成功しました
eroge-release-dbのアクセスの変更に成功しました
```

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

| マイグレーション成功時                                                                                                                              | マイグレーション失敗時                                                                                                                              |
|:----------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------:|
| ![05_notify_deploy_success](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/05_notify_deploy_success.png) | ![06_notify_deploy_failure](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/06_notify_deploy_failure.png) |

## 開発

ローカルで開発を行う方法を説明します  

### 開発ができる状態にする

下記のコマンドを実行すれば開発を行うことができます

```shell
$ docker-compose run --rm runner
```

実行後、下記のような状態になれば大丈夫です

![07_local_development_start](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/07_local_development_start.png)

︙  
︙  
︙  

![08_local_development_end](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/08_local_development_end.png)

### 開発方法

[Railsガイド](https://railsguides.jp/) などの以下のドキュメントを参考にマイグレーションファイルを作成していき開発を行っていきます

- [2 マイグレーションを作成する](https://railsguides.jp/active_record_migrations.html#%E3%83%9E%E3%82%A4%E3%82%B0%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)


### SchemaSpy を使用して定義を確認する

SchemaSpy でファイルを出力し、localhost:8080 にアクセスすることでデータベースの定義を見ることができます

```shell
$ docker-compose run --rm schemaspy && docker-compose up schemaspy_web
```

### 開発環境を削除する

コンテナ、イメージ、ボリューム、ネットワークをすべて一括で削除します

```shell
$ docker-compose down --rmi all --volumes
```

参考記事：[《滅びの呪文》Docker Composeで作ったコンテナ、イメージ、ボリューム、ネットワークを一括完全消去する便利コマンド - Qiita](https://qiita.com/suin/items/19d65e191b96a0079417)
