# 踏み台サーバーの環境構築

パブリックサブネットに踏み台サーバー（EC2）を構築します  
本来ならパブリックサブネットに `Auto Scaling` を使用して踏み台サーバーを構築するのが良いがお金もかかるため今回は `Auto Scaling` を使用しないで構築します

**踏み台サーバーが単一障害点になるためあまりよくない構成です**

## 完成図

以下の環境に踏み台サーバーを構築します

![00_before_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/00_before_stepping_stone_server.png)

構築後は以下のような構成図になります

![01_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/01_stepping_stone_server.png)

では早速、環境を構築していきます

## 踏み台サーバー用のEC2インスタンスを作成する

踏み台サーバー用のためのEC2インスタンスを作成します

### EC2インスタンス作成画面を開く

`インスタンス作成` をクリックします

![02_create_ec2_open](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/02_create_ec2_open.png)

### ステップ１：Amazonマシンイメージ（AMI）

`Amazon Linux 2 AMI (HVM), SSD Volume Type` の `64 ビット (x86)` を選択して `選択` をクリックします

![03_create_ec2_step1](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/03_create_ec2_step1.png)

### ステップ２：インスタンスタイプの選択

`t2.nano` を選択し `次のステップ：インスタンスの詳細の設定` をクリックします  

**お金に余裕がある場合はもう少し上のタイプを選択してもいいでしょう**

![04_create_ec2_step2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/04_create_ec2_step2.png)

### ステップ３：インスタンスの詳細の設定

`ネットワーク`、`サブネット`、`自動割当パブリックIP` を入力します

ネットワークには対象の `VPC` を選択します  
サブネットには `ap-northeast-1aのパブリックサブネット` を選択します  
自動割当パブリックIPは `有効` を選択します（Elastic IPを後で設定しますが一旦有効を設定しておきます）

![05_create_ec2_step3](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/05_create_ec2_step3.png)

#### ユーザーデータ

`ユーザーデータ` は `テキストで` を選択して以下の内容を貼り付けてください  

```shell
#!/bin/bash

# ホスト名の変更
# https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/set-hostname.html
sudo hostnamectl set-hostname eroge-release-stepping-stone-server

# PostgreSQL 11のインストール
# https://qiita.com/libra_lt/items/f2d2d8ee389daf21d3fb
sudo rpm -ivh --nodeps https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo sed -i "s/\$releasever/7/g" "/etc/yum.repos.d/pgdg-redhat-all.repo"
sudo yum install -y postgresql11

# タイムゾーンをAsia/Tokyoに変更する
# https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/set-time.html#change_time_zone
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo sed -i 's|^ZONE=[a-zA-Z0-9\.\-\"]*$|ZONE="Asia/Tokyo”|g' /etc/sysconfig/clock
```

最後に `次のステップ：ストレージの追加` をクリックします

### ステップ４：ストレージの追加

基本的にデフォルトのままで良いでしょう  
`次のステップ：タグの追加` をクリックします

![06_create_ec2_step4](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/06_create_ec2_step4.png)

### ステップ５：タグの追加

`別のタグを追加` をクリックしキーには `Name` を 値にはわかりやすい名前を設定し `次のステップ：セキュリティグループの設定` をクリックします

![07_create_ec2_step5](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/07_create_ec2_step5.png)

### ステップ６：セキュリティグループの設定

`新しいセキュリティグループを作成する` を選択し、`セキュリティグループ名`、`説明` にはわかりやすいものを入力してください  
最後に `確認と作成` をクリックします

**本来なら `ソース` の部分は `0.0.0.0/0` を設定しないでください（フルオープンになっているため）**
**自分の家のグローバルIPアドレスなどを設定してSSHのアクセスを絞り込みます**

![08_create_ec2_step6](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/08_create_ec2_step6.png)

### ステップ７：インスタンス作成の確認

表示されている内容に問題が無ければ `起動` をクリックします

![09_create_ec2_step7](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/09_create_ec2_step7.png)

#### キーペア

`新しいキーペアの作成` を選択し `キーペア名` をわかりやすいものを入力し `キーペアのダウンロード` をクリックします  
最後に `インスタンスの作成` をクリックします

**ダウンロードしたキーペアは踏み台サーバーに接続するのに使用します**

![10_create_ec2_key_pair](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/10_create_ec2_key_pair.png)

### インスタンスの作成中

`インスタンスの表示` をクリックします

![11_create_ec2_creating](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/11_create_ec2_creating.png)

### インスタンスの作成後

インスタンスが作成されたことを確認します  
Elastic IPがまだ設定されていないので今後はElastic IPを設定していきます

![12_create_ec2_created](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/12_create_ec2_created.png)

## Elastic IPを作成する

現状だと踏み台サーバーを起動するたびにIPアドレスが変わってしまうので `Elastic IP` を作成しIPアドレスが固定されるようにします

### Elastic IP アドレスの割り当て画面の表示

`Elastic IP アドレスの割り当て` をクリックします

![13_create_eip_open_setting](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/13_create_eip_open_setting.png)

### Elastic IP アドレスの割り当て

特に設定する部分は無いので `割り当て` をクリックします

![14_create_eip_setting](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/14_create_eip_setting.png)
 
### Elastic IP アドレスの割り当て完了

Elastic IP アドレスの割り当てが完了しました

![15_create_eip_created](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/15_create_eip_created.png)

### Elastic IP アドレスに名前を付ける

名前が無くて分かりづらいのでタグを追加して名前が表示されるようにします

#### Elastic IP アドレスの詳細画面を開く

`Actions` をクリックし `詳細を表示` をクリックします

![16_create_eip_open_detail](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/16_create_eip_open_detail.png)

#### Elastic IP アドレスの詳細

`タグの管理` をクリックします

![17_create_eip_tag](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/17_create_eip_tag.png)

#### タグの管理

`キー` に `Name` と `値 - オプション` にはわかりやすい名前を入力してください  
最後に `保存する` をクリックします

![18_create_eip_tag_editing](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/18_create_eip_tag_editing.png)

タグが追加されました

![19_create_eip_tag_edited](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/19_create_eip_tag_edited.png)

## Elastic IP アドレスをEC2 インスタンスに関連付ける

作成した `Elastic IP アドレス` を先程作成した `踏み台サーバー（EC2）` に関連付けします

### Elastic IP アドレスの関連付け画面を開く

`Elastic IP アドレスの関連付け` をクリックします

![19_create_eip_tag_edited](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/19_create_eip_tag_edited.png)

### Elastic IP アドレスの関連付け

インスタンスの項目は先程作成した `EC2インスタンス` を選択してください  
最後に `関連付ける` をクリックします

![20_attach_eip_to_ec2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/20_attach_eip_to_ec2.png)

### Elastic IP アドレスが関連付けられたか確認する

関連付けられたインスタンスに先程設定したEC2インスタンスが表示されていることが確認できます

![21_attached_eip_to_ec2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/21_attached_eip_to_ec2.png)

EC2インスタンス画面でも `Elastic IP` に先程作成した `Elastic IP アドレス` が表示されていることが確認できます

![22_attached_eip_on_ec2_dashboard](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/22_attached_eip_on_ec2_dashboard.png)

## 実際に接続してみる

以下のようなコマンドを使用し作成した踏み台サーバーにアクセスできるか確認してください

**キーペアはEC2インスタンスを作成した時、ダウンロードしたものになります**

```shell
$ ssh -i キーペア ec2–user@ElasticIPアドレス
```

接続することができたら完了です

![23_connect_to_ec2](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/23_connect_to_ec2.png)

**以上で踏み台サーバーの構築は完了です**

![01_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/01_stepping_stone_server.png)
