# RDSの環境構築

RDSにてPostgreSQLのMaster、Slave構成を構築する

## 完成図

以下の環境にPostgreSQLのMaster、Slave構成を構築します

![00_eroge_release_db_rds_before_create](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/00_eroge_release_db_rds_before_create.png)

構築後は以下のような構成図になります

![01_eroge_release_db_rds](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/01_eroge_release_db_rds.png)

では早速、環境を構築していきます

## DB サブネットグループを作成する

MasterとSlaveをどのサブネットでDBインスタンスを起動するかのための設定になります  

詳しくは以下のドキュメントを確認して下さい

- [VPC の DB インスタンスの使用 - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)

### DB サブネットグループ作成画面を開く

左のメニューの `サブネットグループ` をクリックし右上の `DB サブネットグループを作成` をクリックします

![02_create_subnet_group](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/02_create_subnet_group.png)

### サブネットグループの詳細

`名前`、`説明`、`VPC` を入力します  
**注意：VPCはデフォルトではなく作成したVPCをちゃんと選択するようにしてください**

![03_create_subnet_group_detail](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/03_create_subnet_group_detail.png)

### サブネットを追加

対象のアベイラビリティーゾーン(`1a` と `1c`)の `Private subnet` を追加します  
最後に `作成` ボタンをクリックして終了です

![04_create_subnet_group_add_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/04_create_subnet_group_add_subnet.png)

## パラメータグループの作成

RDSはパラメータグループを使用してDBインスタンスの設定を行います  
パラメータグループを使用しないでDBインスタンスを作成するとデフォルトのパラメータグループが使用されます。この**デフォルトのパラメータグループは設定を変更することができない**ので必ず設定することをオススメします  

詳しくは以下のドキュメントを確認して下さい

- [DB パラメータグループを使用する - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html)

### パラメータグループ作成画面を開く

左のメニューの `パラメータグループ` をクリックし右上の `パラメータグループの作成` をクリックします

![05_create_parameter_group](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/05_create_parameter_group.png)

### パラメータグループの詳細

`パラメータグループファミリー`、`グループ名`、`説明` を入力します  
`パラメータグループファミリー` にはPostgreSQLを選択します  
最後に作成をクリックします

![06_create_paraemter_group_detail](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/06_create_paraemter_group_detail.png)

## RDSへのセキュリティグループを作成

RDSへのセキュリティを高めるために踏み台サーバーからのアクセスのみを許可するセキュリティグループを作成します  
**RDSの設定画面でこのセキュリティグループをアタッチさせます**

### セキュリティグループ作成画面を開く

VPCのコンソール画面を開いて左のメニューの `セキュリティグループ` をクリックし左上の `セキュリティグループの作成` をクリックします

![07_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/07_create_security_group_db.png)

### セキュリティグループの作成

`セキュリティグループ名`、`説明`、`VPC`を入力し `作成` ボタンをクリックします  
**注意：VPCはデフォルトではなく作成したVPCをちゃんと選択するようにしてください**

![08_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/08_create_security_group_db.png)

`閉じる` ボタンをクリックして作成画面を閉じます

![09_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/09_create_security_group_db.png)

### セキュリティグループに名前を付ける

デフォルトだと `name` が空なので `Name` カラムの右端の鉛筆ボタンをクリックしてわかりやすい名前をつけておきます

![10_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/10_create_security_group_db.png)

### インバウンドのルール設定

`インバウンドのルール` タブをクリックして `ルールの編集` をクリックします

![11_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/11_create_security_group_db.png)

画面が遷移したら `ルールの追加` をクリックします

![12_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/12_create_security_group_db.png)

タイプをクリックし `PostgreSQL` と `SSH` を追加します  
ソースの部分には `踏み台サーバーのセキュリティグループ` を選択します  

**踏み台サーバーのセキュリティグループを選択することで踏み台サーバーのセキュリティグループを持つインスタンスからのみアクセスが許可されるようになります**

最後に `説明` を入力して `ルールの保存` をクリックします

![13_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/13_create_security_group_db.png)

`閉じる` ボタンをクリックします

![14_create_security_group_db](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/14_create_security_group_db.png)

以上でセキュリティグループの作成は完了です

## RDSの作成(PostgreSQL)

データベースを作成するための準備が整ったので早速、作成します

### データベースの作成画面を開く

左のメニューの `ダッシュボード` をクリックし下の方の `データベースの作成` をクリックします

![15_create_rds](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/15_create_rds.png)

### データベース作成方法を選択

今回は１つずつ設定していくので `標準作成` を選択します

![16_create_rds_database_create_way](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/16_create_rds_database_create_way.png)

### エンジンのオプション

PostgreSQLのDBを作成するので `PostgreSQL` を選択し `バージョン` も最新のマイナーバージョンのものを選択するとよいでしょう

![17_create_rds_engine](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/17_create_rds_engine.png)

### テンプレート

`無料利用枠` を選択すると `マルチAZ配置` が選択できなくなってしまうので、`開発／テスト` を選択します

![18_create_rds_template](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/18_create_rds_template.png)

### 設定

`DBインスタンス識別子`、`マスターユーザー名`、`マスターパスワード` を入力します  
`DBインスタンス識別子`はコンソール画面上に表示される名前になっています。データベース名では無いので気をつけて下さい  

マスターユーザーについては以下のドキュメントを確認してください

- [マスターユーザーアカウント特権 - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/UsingWithRDS.MasterAccounts.html)

![19_create_rds_settings](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/19_create_rds_settings.png)

### DB インスタンスサイズ

個人で使用するなら料金的に財布に優しい一番スペックの低いものを選びたいですが、`開発／テスト` を選択するとかなりの高スペックが選択されてしまいます

![20_create_rds_db_instance](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/20_create_rds_db_instance.png)

`バースト可能クラス (t クラスを含む)` を選択することで財布に優しいスペックのものが選べるようになります

![21_create_rds_db_instance](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/21_create_rds_db_instance.png)

### ストレージ

個人で使うならデフォルトのままでいいでしょう  
`マルチAZ配置` 構成なら20GBでだいたい月額5ドルぐらいになるかと思います

![22_create_rds_storage](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/22_create_rds_storage.png)

詳しい料金については以下のドキュメントを確認してください

- [料金 - Amazon RDS for PostgreSQL | AWS](https://aws.amazon.com/jp/rds/postgresql/pricing/?pg=pr&loc=3#Database_Storage)

### 可用性と耐久性

`スタンバイインスタンスを作成する (本稼働環境向けに推奨)` を選択することでマルチAZ配置になります  
**注意：テンプレートを 無料利用枠 にしているとグレーアウトで選択できなくなるので必ず 開発／テスト にすること**

![23_create_rds_availability_and_durability](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/23_create_rds_availability_and_durability.png)

### 接続

`Virtual Private Cloud (VPC)` には対象のVPCを入力してください  
**注意：VPCはデフォルトではなく作成したVPCをちゃんと選択するようにしてください**

`追加の接続設定` をクリックし詳細な情報を入力します

`サブネットグループ` には 先程作成したサブネットグループを選択します  

`パブリックアクセス可能` は `なし` を選択します  
**踏み台サーバー経由でアクセスを可能にさせるため なし を選択します**

`VPC セキュリティグループ` には先程作成したセキュリティグループを選択します  

`データベースポート` はデフォルトのままで大丈夫です

![24_create_rds_connection](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/24_create_rds_connection.png)

### データベース認証

IAMの認証情報を使用してデータベースの認証を行う必要が無ければデフォルトの `パスワード認証` で問題ありません  
詳しくは以下のドキュメントを確認して下さい

- [ユーザーが IAM 認証情報で Amazon RDS に接続できるようにする](https://aws.amazon.com/jp/premiumsupport/knowledge-center/users-connect-rds-iam/)

![25_create_rds_database_certification](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/25_create_rds_database_certification.png)

### 追加設定

追加設定についてそれぞれ説明していきます

![26_create_rds_add_settings](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/26_create_rds_add_settings.png)

#### データベースの選択肢

`最初のデータベース名` を指定することでデータベースを作成した状態でRDSを構築してくれます  

![28_create_rds_add_settings_default_database](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/28_create_rds_add_settings_default_database.png)

`DB パラメータグループ` には先程作成したパラメータグループを指定します

![27_create_rds_add_settings_choise_database](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/27_create_rds_add_settings_choise_database.png)

#### バックアップ

`バックアップウィンドウ` では `選択ウィンドウ` を選択し、`開始時間` を `20:00` に設定しています  
この設定にすることで 朝の5時に30分の間でバックアップを取るようになります

![29_create_rds_add_settings_backup](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/29_create_rds_add_settings_backup.png)

詳しくは以下のドキュメントを確認してください

- [バックアップの使用 - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow)

#### Performance Insights

Performance Insightsに関してはデフォルトのままで良いでしょう

![30_create_rds_add_settings_perfomance_insights](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/30_create_rds_add_settings_perfomance_insights.png)

詳しくは以下のドキュメントを確認してください

- [Performance Insights（RDSのパフォーマンスを分析、チューニング）| AWS](https://aws.amazon.com/jp/rds/performance-insights/)
- [パフォーマンスインサイトの有効化 - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_PerfInsights.Enabling.html)

#### モニタリング

モニタリングに関してはデフォルトのままで良いでしょう

![31_create_rds_add_settings_monitoring](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/31_create_rds_add_settings_monitoring.png)

詳しくは以下のドキュメントを確認してください

- [Amazon RDS​ のモニタリングの概要 - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/MonitoringOverview.html)
- [拡張モニタリング - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html)

#### ログのエクスポート

`Pstgresql ログ`、`アップグレードログ` にチェックをいれます  
チェックを入れることで `CloudWatch Logs` で出力されたログを確認することができます

![32_create_rds_add_settings_log_export](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/32_create_rds_add_settings_log_export.png)

ログに関しては以下のドキュメントを確認して下さい

- [Amazon RDS データベースログファイル - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_LogAccess.html)
- [PostgreSQL データベースのログファイル - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_LogAccess.Concepts.PostgreSQL.html)
- [Amazon RDS または Aurora for MySQL のログを CloudWatch に公開](https://aws.amazon.com/jp/premiumsupport/knowledge-center/rds-aurora-mysql-logs-cloudwatch/)

#### メンテナンス

`メンテナンスウィンドウ` では `選択ウィンドウ` を選択し、`開始時間` を `18:00` に設定しています  
この設定にすることで 火曜日の朝の3時に30分の間でマイナーバージョンのアップグレードをしてくれるようになります

![33_create_rds_add_settings_maintenance](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/33_create_rds_add_settings_maintenance.png)

マイナーバージョンのアップグレードに関しては以下のドキュメントを確認して下さい

- [DB インスタンス のエンジンバージョンのアップグレード - Amazon Relational Database Service](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades)

#### 削除保護

チェックをすることでデータベースを削除することができなくなります  
**設定を変更することで削除することができるようになります**

![34_create_rds_add_settings_deletion_protection](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/34_create_rds_add_settings_deletion_protection.png)

### データベースの作成

最後に `概算月間コスト` を確認して、大丈夫そうなら `データベースの作成` ボタンをクリックします  
これでRDS構築完了です！

![35_create_rds_create_button](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/35_create_rds_create_button.png)

料金の詳細については以下のドキュメントを確認してください

- [料金 - Amazon RDS for PostgreSQL | AWS](https://aws.amazon.com/jp/rds/postgresql/pricing/?pg=pr&loc=3)

## PostgreSQLについて

PostgreSQLで環境構築をするにあたって必要な用語を最低限おさらいします

### データベースクラスタ

データベースクラスタはデータベースの集合になります  

![36_postgresql_database_cluster](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/36_postgresql_database_cluster.png)

RDSで作成した場合はデータベースクラスタに `RDSの設定画面で設定した最初のデータベース`、`postgres`、`rdsadin`、`tempalte0`、`template1` が作成された状態になっています

![28_create_rds_add_settings_default_database](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/28_create_rds_add_settings_default_database.png)

詳しくは以下のドキュメントを確認してください

- [18.2. データベースクラスタの作成](https://www.postgresql.jp/document/11/html/creating-cluster.html)

### データベース

データベースはデータベースオブジェクト（テーブル、ビュー、関数および演算子など）の集合に名前をつけたものです

![37_postgresql_database](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/37_postgresql_database.png)

詳しくは以下のドキュメントを確認してください

- [22.1. 概要](https://www.postgresql.jp/document/11/html/manage-ag-overview.html)
- [22.2. データベースの作成](https://www.postgresql.jp/document/11/html/manage-ag-createdb.html)

### スキーマ

スキーマはデータベース内のデータベースオブジェクト（テーブル、ビュー、関数および演算子など）をグループ化することができます  

![38_postgresql_schema](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/38_postgresql_schema.png)

詳しくは以下のドキュメントを確認してください

- [5.8. スキーマ](https://www.postgresql.jp/document/11/html/ddl-schemas.html)

### ロールについて

ロールはデータベースへの接続承認を行う。ロールにはデータベースユーザ(データベースへログインするユーザー)とデータベースユーザのグループと分けられます

ロールを作成するSQLには以下の２つがあります  
２つの違いはLOGIN属性を持つかどうかです 

```sql
-- データベースユーザーのグループを作成
CREATE ROLE name;
-- データベースユーザーを作成
CREATE USER name;
```

詳しくは以下のドキュメントを確認してください

- [21.1. データベースロール](https://www.postgresql.jp/document/11/html/database-roles.html)
- [21.2. ロールの属性](https://www.postgresql.jp/document/11/html/role-attributes.html)
- [21.3. ロールのメンバ資格](https://www.postgresql.jp/document/11/html/role-membership.html)

## ユーザーとロールの管理を行う

AWSのブログ記事を参考に `ユーザーとロールを管理するためのベストプラクティス` を元に環境を構築していきます  
以下の２つの記事を参考に作成していきます

- [PostgreSQL ユーザーとロールの管理 | Amazon Web Services ブログ](https://aws.amazon.com/jp/blogs/news/managing-postgresql-users-and-roles/)
- [Managing PostgreSQL users and roles | AWS Database Blog](https://aws.amazon.com/jp/blogs/database/managing-postgresql-users-and-roles/)

### 目指すべきゴール

![managing-postgresql-users-1](https://d2908q01vomqb2.cloudfront.net/887309d048beef83ad3eabf2a79a64a389ab1c9f/2019/03/01/managing-postgresql-users-1.gif)

> - マスターユーザーを使用して、`readonly` や `readwrite` などのアプリケーションまたはユースケースごとにロールを作成します
> - これらのロールがさまざまなデータベースオブジェクトにアクセスできるように権限を追加します。例えば、`readonly` ロールは `SELECT` クエリのみを実行できます
> - 機能にとって最低限必要な権限をロールに付与します
> - `app_user` や `reporting_user` のように、アプリケーションごとまたは個別の機能ごとに新しいユーザーを作成します
> - 適切なロールをこれらのユーザーに割り当てて、ロールと同じ権限をすばやく付与します。例えば、`readwrite` ロールを `app_user` に付与し、`readonly` ロールを `reporting_user` に付与します
> - いつでも、権限を取り消すためにユーザーからロールを削除できます

上記、画像と文章は [PostgreSQL ユーザーとロールの管理 | Amazon Web Services ブログ](https://aws.amazon.com/jp/blogs/news/managing-postgresql-users-and-roles/) より引用

言っていることは `読み取り権限`、`読み取り/書き込み権限` などのグループロールを作成し、それを用途に応じたユーザーに付与する  

### publicスキーマ

**注意：これからの作業は `踏み台サーバー `から `マスターユーザー` で RDS に接続して実行します**

新しくデータベースを作成すると `publicスキーマ` が作成されます  
テーブルなどのデータベースオブジェクトを作成すると `publicスキーマ` に所属することになります  

新しくユーザーを作成して権限を付与して制限を行っても `publicスキーマ` に作成されてしまうので新しく作成したユーザーが意味のないものになってしまいます  
`publicスキーマ` への作成権限を取り消す必要があります

PostgreSQLの公式のドキュメントに以下のように書かれています

> 標準SQLには、publicスキーマという概念もありません。 標準に最大限従うためには、publicスキーマは使用すべきではありません。

`publicスキーマ` は使わない方向でいくのが良いでしょう  
詳しくは以下の公式ドキュメントを確認してください

- [5.8.7. 移植性](https://www.postgresql.jp/document/11/html/ddl-schemas.html#DDL-SCHEMAS-PORTABILITY)

#### publicスキーマを使用できないようにする

以下のSQLを実行して `publicスキーマ` を使用できないようにする

![39_revoke_public_schema](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/39_revoke_public_schema.png)

```sql
-- public ロールから public スキーマに対するデフォルトの作成権限を取り消す
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

-- publicロールがデータベースに接続する機能を無効にする
-- ※eroge_release_dbはデータベース名です
REVOKE ALL ON DATABASE eroge_release_db FROM PUBLIC;
```

### スキーマを作成する

本来ならば作成するユーザーごとにスキーマを作成するのが良いのですが今回はスキーマを1つだけ作成してすべてのユーザーはそのスキーマをみるようにします

スキーマのオススメの使用パターンは公式のドキュメントを確認してください

- [5.8.6. 使用パターン](https://www.postgresql.jp/document/11/html/ddl-schemas.html#DDL-SCHEMAS-PATTERNS)

以下のSQLを実行してスキーマを作成します

![40_create_schema](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/40_create_schema.png)

```sql
-- スキーマの作成
-- ※eroge_release_db_schemaはスキーマ名です
CREATE SCHEMA eroge_release_db_schema;
```

### 読み取り権限ロールを作成する

データの読み取りのみを許可したロールを作成します  
データの更新ができないロールになります  

また今後作成されるテーブルやビューに `readonly` ロールがアクセスできるように権限を自動付与する

以下のSQLを実行します

![41_create_readonly_role](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/41_create_readonly_role.png)

```sql
-- readonlyという名前のロールを作成(パスワードも権限もないロール)
CREATE ROLE readonly;

-- readonlyロールはeroge_release_dbへのアクセス権限を付与する
-- ※eroge_release_dbはデータベース名です
GRANT CONNECT ON DATABASE eroge_release_db TO readonly;

-- readonlyロールにスキーマへのアクセス権限を付与する
-- ※eroge_release_db_schemaはスキーマ名です
GRANT USAGE ON SCHEMA eroge_release_db_schema TO readonly;

-- スキーマ内のすべてのテーブルとビューへのアクセス権限を付与する
-- ※eroge_release_db_schemaはスキーマ名です
GRANT SELECT ON ALL TABLES IN SCHEMA eroge_release_db_schema TO readonly;

-- 今後新しいテーブルやビューが作成された時はアクセス権限がない状態になる
-- なので今後新しいテーブルやビューが作成された時はアクセス権限を自動的に付与する
-- ※eroge_release_db_schemaはスキーマ名です
ALTER DEFAULT PRIVILEGES IN SCHEMA eroge_release_db_schema GRANT SELECT ON TABLES TO readonly;
```

### 読み取り/書き込み権限ロールを作成する

データの読み取りにプラスして書き込みを許可したロールを作成します

また今後作成されるテーブルやビューに `readwrite` ロールがアクセスできるように権限を自動付与する

以下のSQLを実行します

![42_create_readwrite_role](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/42_create_readwrite_role.png)

```sql
-- readwriteという名前のロールを作成(パスワードも権限もないロール)
CREATE ROLE readwrite;

-- readwriteロールはeroge_release_dbへのアクセス権限を付与する
-- ※eroge_release_dbはデータベース名です
GRANT CONNECT ON DATABASE eroge_release_db TO readwrite;

-- readwriteロールにスキーマへ新しいObjectを作成する権限を付与する
-- ※eroge_release_db_schemaはスキーマ名です
GRANT USAGE, CREATE ON SCHEMA eroge_release_db_schema TO readwrite;

-- スキーマ内のすべてのテーブルとビューへのアクセス権限、及び追加・削除・更新の権限を付与する
-- ※eroge_release_db_schemaはスキーマ名です
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA eroge_release_db_schema TO readwrite;

-- 今後新しいテーブルやビューが作成された時はアクセス権限、及び追加・削除・更新の権限がない状態になる
-- なので今後新しいテーブルやビューが作成された時はアクセス権限、及び追加・削除・更新の権限を自動的に付与する
-- ※eroge_release_db_schemaはスキーマ名です
ALTER DEFAULT PRIVILEGES IN SCHEMA eroge_release_db_schema GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;

-- シーケンスも使用する必要があるためシーケンスへのアクセス権限を付与する
-- ※eroge_release_db_schemaはスキーマ名です
GRANT USAGE ON ALL SEQUENCES IN SCHEMA eroge_release_db_schema TO readwrite;

-- 今後新しいシーケンスが作成された時はアクセス権限がない状態になる
-- なので今後新しいシーケンスが作成された時はアクセス権限を自動的に付与する
-- ※eroge_release_db_schemaはスキーマ名です
ALTER DEFAULT PRIVILEGES IN SCHEMA eroge_release_db_schema GRANT USAGE ON SEQUENCES TO readwrite;
```

### ユーザーを作成しロールを付与する

ログイン用のユーザーを作成し先程作成したロールを付与します  
`読み取り` と `読み取り/書き込み` 用それぞれのユーザーを作成します  

- app_readonly (読み取り)
- app (読み取り/書き込み)

以下のSQLを実行してください

![43_create_users](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/43_create_users.png)

```sql
-- readonlyユーザーの作成し 読み取り権限ロール を付与する
-- ※app_readonlyはユーザー名です、passwordはログインする時のパスワードです
CREATE USER app_readonly WITH PASSWORD 'password';
GRANT readonly TO app_readonly;

-- readwriteユーザーの作成し 読み取り/書き込み権限ロール を付与する
-- ※appはユーザー名です、passwordはログインする時のパスワードです
CREATE USER app WITH PASSWORD 'password';
GRANT readwrite TO app;
```

### ユーザーとロールが作成されたか確認

`app`、`app_readonly` ユーザーが表示され、ロールがそれぞれちゃんと付与されているか以下のSQLを実行して確認してください

![44_confirmation_user_list](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/db_construction/44_confirmation_user_list.png)

```sql
-- 権限の確認SQL
  SELECT r.rolname
       , ARRAY(
                   SELECT b.rolname
                     FROM pg_catalog.pg_auth_members m
                     JOIN pg_catalog.pg_roles        b 
                       ON m.roleid = b.oid
                    WHERE m.member = r.oid
               ) AS memberof
    FROM pg_catalog.pg_roles r
   WHERE r.rolname NOT IN (
                               'pg_execute_server_program', 'pg_monitor',           'pg_read_all_settings',
                               'pg_read_all_stats',         'pg_read_server_files', 'pg_stat_scan_tables',
                               'pg_write_server_files',     'rds_ad',               'rdsadmin',                  
                               'rds_password',              'pg_signal_backend',    'rds_iam',                   
                               'rds_replication',           'rdsrepladmin',         'rds_superuser'
                          )
ORDER BY r.rolname;
```
