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
