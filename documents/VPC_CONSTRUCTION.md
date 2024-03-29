# VPCの環境構築

VPCの環境構築を行います  
ap-northeast-1a、ap-northeast-1cそれぞれのアベイラビリティーゾーンにパブリックサブネット、プライベートサブネットを１つずつ作成していきます  

## 完成図

最終的には下記のような構成になります

![00_eroge_release_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/00_eroge_release_vpc.png)

## VPCの作成

VPCウィザードを使用して `VPC`、`パブリックサブネット`、`インターネットゲートウェイ` を作成します  

### Terraform で作成する

現在は Terraform 化されているため、コマンド一発で環境を構築できます

```shell
# ネットワーク作成ディレクトリへ移動
$ cd terraform/components/network

# Terraform で作成する
$ terraform apply -parallelism=30
```

### VPCウィザードを開く

`VPCダッシュボード` の画面で `VPCウィザードの起動` をクリックして下さい

![01_create_vpc_dashboard](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/01_create_vpc_dashboard.png)

### ステップ１：VPC設定の選択

![02_create_vpc_wizard_step1](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/02_create_vpc_wizard_step1.png)

`選択` をクリックします

### ステップ２：１個のパブリックサブネットを持つVPC

`VPC名`、`パブリックサブネットの IPv4 CIDR`、`アベイラビリティーゾーン`、`サブネット名` を入力して `VPCの作成` をクリックします 

**`パブリックサブネットの IPv4 CIDR` には `10.0.11.0/24` を入力してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1a` を入力してください**  
**`VPC名` と `サブネット名` には任意の名前を入力してください**

![03_create_vpc_wizard_step2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/03_create_vpc_wizard_step2.png)

### VPCが正常に作成されました

`OK` をクリックしてください

![04_create_vpc_wizard_ok](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/04_create_vpc_wizard_ok.png)

### VPCが作成されたか確認する

VPCが作成されていることを確認します

![05_create_vpc_created_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/05_create_vpc_created_vpc.png)

### パブリックサブネットが作成されたか確認する

パブリックサブネットが作成されていることを確認します

![06_create_vpc_created_public_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/06_create_vpc_created_public_subnet.png)

ルートテーブルにIGW（インターネットゲートウェイ）が設定されていることを確認します

![07_create_vpc_created_public_subnet_route](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/07_create_vpc_created_public_subnet_route.png)

### IGW（インターネットゲートウェイ）が作成されたか確認する

IGW（インターネットゲートウェイ）が作成されていることを確認します

![08_create_vpc_created_internet_gateway](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/08_create_vpc_created_internet_gateway.png)

### VPCの作成後

以上で以下の状態まで作成できました

![09_cretae_vpc_and_public_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/09_cretae_vpc_and_public_subnet.png)

## パブリックサブネットを作成

アベイラビリティーゾーンの `ap-northeast-1a` にパブリックサブネットが作成されたので `ap-northeast-1c` にもパブリックサブネットを作成していきます

### サブネット作成画面を開く

`サブネット` の画面で `サブネットの作成` をクリックして下さい

![10_create_public_subnet_open](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/10_create_public_subnet_open.png)

### サブネットの作成

`名前タグ`、`VPC`、`アベイラビリティーゾーン`、`IPv4 CIDR ブロック` を入力して `作成` をクリックします 

**`VPC` には作成したVPCを選択してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1c` を入力してください**  
**`IPv4 CIDRブロック` には `10.0.12.0/24` を入力してください**  

![11_create_public_subnet_screen](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/11_create_public_subnet_screen.png)

`閉じる` をクリックします

![12_create_public_subent_created_close](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/12_create_public_subent_created_close.png)

### ルートテーブルの関連付けの編集画面を開く

新しく作成された `ap-northeast-1c` のサブネットを選択します  
ルートテーブルに `IGW（インターネットゲートウェイ）` が設定されていないため、現状だとこのサブネットはインターネットに出ることが出来ないため、 `プライベートサブネット` になっています  

ルートテーブルに `IGW（インターネットゲートウェイ）` を設定します 
`ルートテーブルの関連付けの編集` をクリックします

![13_create_public_subent_created](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/13_create_public_subent_created.png)

### ルートテーブルの関連付けの編集画面

![14_create_public_subent_edit_route_table](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/14_create_public_subent_edit_route_table.png)

先程作成された `ルートテーブル` に変更します

![15_create_public_subent_select_route_table_id](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/15_create_public_subent_select_route_table_id.png)

`IGW（インターネットゲートウェイ）` が追加されていることが確認できます  
問題なければ `保存` をクリックします

![16_create_public_subnet_editding_route_table](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/16_create_public_subnet_editding_route_table.png)

`閉じる` をクリックします

![17_create_public_subent_route_table_close](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/17_create_public_subent_route_table_close.png)

### IGW（インターネットゲートウェイ）が追加されているか確認する

ルートテーブルに `IGW（インターネットゲートウェイ）` が追加されていることを確認します

![18_create_public_subent_edited_route_table](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/18_create_public_subent_edited_route_table.png)

### パブリックサブネットの作成後

以上で以下の状態まで作成されました

![19_create_public_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/19_create_public_subnet.png)

## プライベートサブネットを作成

パブリックサブネット同様にプライベートサブネットを作成していきます

### ap-northeast-1aに作成

`ap-northeast-1a` にサブネットを作成していきます   

#### サブネット作成画面を開く

`サブネット作成` をクリックします

![20_create_private_subent_open_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/20_create_private_subent_open_1a.png)

#### サブネット作成

`名前タグ`、`VPC`、`アベイラビリティーゾーン`、`IPv4 CIDR ブロック` を入力して `作成` をクリックします 

**`VPC` には作成したVPCを選択してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1a` を入力してください**  
**`IPv4 CIDRブロック` には `10.0.21.0/24` を入力してください**  

![21_create_private_subent_editing_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/21_create_private_subent_editing_1a.png)

`閉じる` をクリックします

![22_create_private_subent_created_close_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/22_create_private_subent_created_close_1a.png)

### ap-northeast-1cに作成

`ap-northeast-1c` にサブネットを作成していきます   

#### サブネット作成画面を開く

`ap-northeast-1a` にサブネットが作成されています  

`ap-northeast-1c` にもサブネットを作成していきます
 `サブネット作成` をクリックします

![23_create_private_subent_created_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/23_create_private_subent_created_1a.png)

#### サブネット作成

`名前タグ`、`VPC`、`アベイラビリティーゾーン`、`IPv4 CIDR ブロック` を入力して `作成` をクリックします 

**`VPC` には作成したVPCを選択してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1c` を入力してください**  
**`IPv4 CIDRブロック` には `10.0.22.0/24` を入力してください**  

![24_create_private_subent_editing_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/24_create_private_subent_editing_1c.png)

`閉じる` をクリックします

![25_create_private_subent_created_close_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/25_create_private_subent_created_close_1c.png)

作成されたことを確認します

![26_create_private_subent_created_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/26_create_private_subent_created_1c.png)

### プライベートサブネット用のルートテーブルを作成する

プライベート用のサブネットを作成していきます

#### パブリックサブネット用のルートテーブルに名前を付ける

プライベート用のサブネットを作成する前にわかりやすいように名前をつけます

![27_create_private_route_table_public_route_table_name](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/27_create_private_route_table_public_route_table_name.png)

#### ルートテーブルの作成画面を開く

`ルートテーブルの作成` をクリックします

![28_create_private_route_table_open_create_route_table](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/28_create_private_route_table_open_create_route_table.png)

#### ルートテーブルの作成

`名前タグ`、`VPC` を入力して `作成` をクリックします

**`VPC` には作成したVPCを選択してください**  

![29_create_private_route_table_create_route_table_editing](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/29_create_private_route_table_create_route_table_editing.png)

`閉じる` をクリックします

![30_create_private_route_table_created_close](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/30_create_private_route_table_created_close.png)

作成されたことを確認します

![31_create_private_route_table_created](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/31_create_private_route_table_created.png)

### ap-northeast-1a に作成したサブネットにルートテーブルに関連付ける

プライベート用に作成したルートテーブルをサブネットに紐付けていきます  

#### ルートテーブルの関連付けの編集画面を開く

`ルートテーブルの関連付けの編集` をクリックします

![32_create_private_route_table_open_edit_route_table_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/32_create_private_route_table_open_edit_route_table_1a.png)

#### ルートテーブルの関連付けの編集

先程作成したルートテーブルを選択し `保存` をクリックします

![33_create_private_route_table_edit_route_table_editing_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/33_create_private_route_table_edit_route_table_editing_1a.png)

`閉じる` をクリックします

![34_create_private_route_table_edit_route_table_close_1a](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/34_create_private_route_table_edit_route_table_close_1a.png)

### ap-northeast-1c に作成したサブネットにルートテーブルに関連付ける

プライベート用に作成したルートテーブルをサブネットに紐付けていきます  

#### ルートテーブルの関連付けの編集画面を開く

`ルートテーブルの関連付けの編集` をクリックします

![35_create_private_route_table_open_edit_route_table_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/35_create_private_route_table_open_edit_route_table_1c.png)

#### ルートテーブルの関連付けの編集

先程作成したルートテーブルを選択し `保存` をクリックします

![36_create_private_route_table_edit_route_table_editing_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/36_create_private_route_table_edit_route_table_editing_1c.png)

`閉じる` をクリックします

![37_create_private_route_table_edit_route_table_close_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/37_create_private_route_table_edit_route_table_close_1c.png)

### プライベート用のルートテーブルに紐付いたか確認する

ルートテーブルにサブネットが紐付いているのを確認できます

![38_create_private_route_table_editing](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/38_create_private_route_table_editing.png)

**以上でVPCの構築は完了です**

![00_eroge_release_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/00_eroge_release_vpc.png)
