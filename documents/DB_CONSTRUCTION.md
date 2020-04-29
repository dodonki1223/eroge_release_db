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