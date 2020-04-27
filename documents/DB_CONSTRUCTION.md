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

詳しくは以下の記事を読みましょう

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

詳しくは以下の記事を読みましょう

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
