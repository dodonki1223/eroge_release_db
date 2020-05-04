# VPCの環境構築

VPCの環境構築を行います  
ap-northeast-1a、ap-northeast-1cそれぞれのアベイラビリティーゾーンにパブリックサブネット、プライベートサブネットを１つずつ作成していきます  

## 完成図

最終的には下記のような構成になります

![00_eroge_release_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/00_eroge_release_vpc.png)

## VPCの作成

VPCウィザードを使用して `VPC`、`パブリックサブネット`、`インターネットゲートウェイ` を作成します  
`VPCダッシュボード` の画面で `VPCウィザードの起動` をクリックして下さい

![01_create_vpc_dashboard](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/01_create_vpc_dashboard.png)

`選択` をクリックします

![02_create_vpc_wizard_step1](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/02_create_vpc_wizard_step1.png)

`VPC名`、`パブリックサブネットの IPv4 CIDR`、`アベイラビリティーゾーン`、`サブネット名` を入力して `VPCの作成` をクリックします 

**`パブリックサブネットの IPv4 CIDR` には `10.0.11.0/24` を入力してください**  
**`アベイラビリティーゾーン` には `ap-northeast-1a` を入力してください**  
**`VPC名` と `サブネット名` には任意の名前を入力してください**

![03_create_vpc_wizard_step2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/03_create_vpc_wizard_step2.png)

`OK` をクリックしてください

![04_create_vpc_wizard_ok](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/04_create_vpc_wizard_ok.png)

VPCが作成されていることを確認します

![05_create_vpc_created_vpc](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/05_create_vpc_created_vpc.png)

パブリックサブネットが作成されていることを確認します

![06_create_vpc_created_public_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/06_create_vpc_created_public_subnet.png)

ルートテーブルにIGW（インターネットゲートウェイ）が設定されていることを確認します

![07_create_vpc_created_public_subnet_route](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/07_create_vpc_created_public_subnet_route.png)

IGW（インターネットゲートウェイ）が作成されていることを確認します

![08_create_vpc_created_internet_gateway](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/08_create_vpc_created_internet_gateway.png)

以上で以下の状態まで作成できました

![09_cretae_vpc_and_public_subnet](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/vpc_construction/09_cretae_vpc_and_public_subnet.png)
