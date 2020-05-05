# 踏み台サーバーの環境構築

パブリックサブネットに踏み台サーバーを構築します  
本来ならパブリックサブネットに `Auto Scaling` を使用して踏み台サーバーを構築するのが良いがお金もかかるため今回は `Auto Scaling` を使用しないで構築します

**踏み台サーバーが単一障害点になるためあまりよくない構成です**

## 完成図

以下の環境に踏み台サーバーを構築します

![00_before_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/00_before_stepping_stone_server.png)

構築後は以下のような構成図になります

![01_stepping_stone_server](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/stepping_stone_server_construction/01_stepping_stone_server.png)

では早速、環境を構築していきます

