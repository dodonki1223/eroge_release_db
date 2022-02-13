# CircleCIの環境構築

GitHubにリポジトリを作っただけではCircleCIとの連携が出来ていません  
CircleCIと連携するための設定を行います

## GitHubとCircleCIを連携させる

[https://app.circleci.com/projects/project-dashboard/github/ユーザー名](https://app.circleci.com/projects/project-dashboard/github/ユーザー名)にアクセスしてください  

`Set up Project` をクリックします

![00_projects](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/00_projects.png)

config.ymlが既にある場合は `Add Manually` をクリックします  
**config.ymlが存在しない場合は説明しません**

![01_add_manually](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/01_add_manually.png)

`Start Building` をクリックします

![02_start_building](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/02_start_building.png)

下記の画面になったら連携完了です  

![03_run_workflow](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/03_run_workflow.png)

## 環境変数を設定する

config.ymlで環境変数を使用している場合は画面上から設定が必要です  
`Project Settings` をクリックします

![04_project_settings](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/04_project_settings.png)

`Environment Valiables` 画面で環境変数を追加する場合は `Add Environment Variable` をクリックします

![05_environment_valiables](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/05_environment_valiables.png)

環境変数には以下の値を設定してください

| 環境変数名                          | 説明                                                                             |
|:------------------------------------|:---------------------------------------------------------------------------------|
| BASTION_SERVER_HOST                 | `踏み台サーバーのパブリックDNS(IPv4)` または `IPv4パブリックIP`                  |
| BASTION_SERVER_PRIVATE_KEY          | `踏み台サーバーにアクセスするための Private ssh key を base64 でエンコードした値 |
| BASTION_SERVER_USER                 | 踏み台サーバーのユーザー名（デフォルト：ec2-user）                               |
| DOCKERHUB_PASSWORD                  | Docker Hubのログインユーザーのパスワード                                         |
| DOCKERHUB_USER                      | Docker Hubのログインユーザー                                                     |
| EROGE_RELEASE_DB_HOST               | RDSのエンドポイント                                                              |
| EROGE_RELEASE_DB_LOCAL_PORT         | ポートフォワーディングで使用するポート番号                                       |
| EROGE_RELEASE_DB_NAME               | RDSで作成したデータベース名                                                      |
| EROGE_RELEASE_DB_PASSWORD           | masterユーザーのパスワード                                                       |
| EROGE_RELEASE_DB_PORT               | RDSのポート番号（デフォルト：5432）                                              |
| EROGE_RELEASE_DB_SCHEMA_SEARCH_PATH | RDSで設定したsearch_path                                                         |
| EROGE_RELEASE_DB_USER               | RDSで設定したmasterユーザー名                                                    |
| RAILS_MASTER_KEY                    | Railsのmaster.key                                                                |
| SLACK_WEBHOOK                       | Slackの `Webhook URL`                                                            |

`BASTION_SERVER_PRIVATE_KEY` に設定する値はローカルにある private ssh key を以下のコマンドで得られた値を設定してください

```shell
$ cat .ssh/eroge-release.id_rsa | base64
```

`master.key` については以下を参照してください

- [10.1 独自のcredential - Railsガイド](https://railsguides.jpk/security.html#%E7%8B%AC%E8%87%AA%E3%81%AEcredential)
- [Rails5.2から追加された credentials.yml.enc のキホン - Qiita](https://qiita.com/NaokiIshimura/items/2a179f2ab910992c4d39)

最終的に下記のように設定されていれば問題ないです

![06_setted_einvrionment_valiables](https://raw.githubusercontent.com/dodonki1223/image_garage/master/eroge_release_db/circleci_construction/06_setted_einvrionment_valiables.png)

**以上でCircleCIの環境構築は完了です**
