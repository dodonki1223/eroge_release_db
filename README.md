# eroge_release_db [![CircleCI](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master.svg?style=svg)](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master)

美少女ゲームのブランド、ゲーム情報、出演声優、声優情報などを管理するためのデータベースです

![00_eroge_release_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/readme/00_eroge_release_db.png)

## 概要

Master、Slave構成のRDS（PostgreSQL）内のデータベースのバージョン管理をRailsの `Active Record マイグレーション` を使用して管理します  
データベースの `設計` や `バージョン管理` を行うためのリポジトリでデータの挿入などは行いません（別のプロジェクトで行います）

## データベースER図

![eroge_release_db](https://raw.githubusercontent.com/dodonki1223/eroge_release_db/master/db/erd/eroge_release_db.png)

[Rails ERD](https://github.com/voormedia/rails-erd) を使用してデータベースのER図を出力しています
