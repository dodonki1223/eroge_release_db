# VPCの環境構築

VPCの環境構築を行います  
ap-northeast-1a、ap-northeast-1cそれぞれのアベイラビリティーゾーンにパブリックサブネット、プライベートサブネットを１つずつ作成していきます  

## 完成図

最終的には下記のような構成になります

![00_eroge_release_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/00_eroge_release_vpc.png)

## VPCの作成

VPCウィザードを使用して `VPC`、`パブリックサブネット`、`インターネットゲートウェイ` を作成します  

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

#### サブネット作成画面

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

#### サブネット作成画面

`名前タグ`、`VPC`、`アベイラビリティーゾーン`、`IPv4 CIDR ブロック` を入力して `作成` をクリックします 

**`VPC` には作成したVPCを選択してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1c` を入力してください**  
**`IPv4 CIDRブロック` には `10.0.22.0/24` を入力してください**  

![24_create_private_subent_editing_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/24_create_private_subent_editing_1c.png)

`閉じる` をクリックします

![25_create_private_subent_created_close_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/25_create_private_subent_created_close_1c.png)

作成されたことを確認します

![26_create_private_subent_created_1c](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/26_create_private_subent_created_1c.png)
