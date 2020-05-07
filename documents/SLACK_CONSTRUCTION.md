# Slackの環境構築

`Rails` 、`CircleCI` を使用して `RDS` へ `マイグレーションを実行する` ことでデータベースを自動で更新していきます  
更新の実行有無、実行結果通知をSlackで行うためSlackの設定が必要です  
CircleCIからの通知を受けるための設定を行います

## Incoming Webhookをインストール

[https://ワークスペース名.slack.com/apps](https://ワークスペース名.slack.com/apps) にアクセスし `webhook` と入力します  
検索のリストに出てきた `Incoming Webhook` をクリックします

![02_search_incoming_webhook](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/slack_construction/02_search_incoming_webhook.png)

`Slackに追加` をクリックします

![03_add_slack](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/slack_construction/03_add_slack.png)

`通知させるチャンネル` を選択し `Incoming Webhook インテグレーションの追加` をクリックします  
このサンプルでは `general` チャンネルに通知されるように設定しています

![04_select_channel](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/slack_construction/04_select_channel.png)

詳細の設定画面では 名前とアイコンをカスタマイズすることでなんの通知かわかりやすくなるので設定しておきましょう

![05_customize_name_and_icon](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/slack_construction/05_customize_name_and_icon.png)

`設定を保存する` をクリックして下記の画面になれば大丈夫です

![06_setting_end](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/slack_construction/06_setting_end.png)

## スタンプを追加する

通知用にカスタム絵文字を使用するので以下の3つを追加してください  
追加する時は `カスタム絵文字を追加する` をクリックしてください

- :circleci-fail:
- :circleci-pass:
- :github_octocat:

![07_custom_emoji](https://raw.githubusercontent.com/dodonki1223/image_garage/master/template_sample_rails6/slack/07_cutom_emoji.png)

- GitHubのアイコンは[こちらから](https://github.com/logos)ダウンロードできます
- CircleCIのアイコンは[メール通知](https://circleci.com/docs/ja/2.0/notifications/#%E3%83%A1%E3%83%BC%E3%83%AB%E9%80%9A%E7%9F%A5%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%81%A8%E5%A4%89%E6%9B%B4)のものを使用すると良いと思います

**以上でSlackの構築は完了です**
