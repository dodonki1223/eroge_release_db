#!/bin/sh

# 実行スクリプトのフォルダへ移動（この記述をすることで実行場所を選ばないスクリプトになる）
cd `dirname $0`

read -p "tfstateを格納するS3バケット名を入力して下さい: " BUCKET_NAME
read -p "S3バケット作成で使用するprofile名を入力してください: " PROFILE_NAME

# バケットの作成
echo "${BUCKET_NAME}の作成を行います"
aws s3 mb s3://${BUCKET_NAME} \
  --profile ${PROFILE_NAME}

# バケットのバージョニング設定の変更
printf '\r%50s' "${BUCKET_NAME}にバージョンニングを有効化します……"
aws s3api put-bucket-versioning \
  --profile ${PROFILE_NAME} \
  --bucket ${BUCKET_NAME} \
  --versioning-configuration Status=Enabled && \
printf '\r%-50s\n' "${BUCKET_NAME}にバージョンニングを有効化に成功しました"

# バケットのサーバー側の暗号化を設定
printf '\r%50s' "${BUCKET_NAME}にサーバー側の暗号化を有効化します……"
BUCKET_ENCRYPTION=`cat config/config-bucket-encryption.json`
aws s3api put-bucket-encryption \
  --profile ${PROFILE_NAME} \
  --bucket ${BUCKET_NAME} \
  --server-side-encryption-configuration "${BUCKET_ENCRYPTION}" && \
printf '\r%-50s\n' "${BUCKET_NAME}にサーバー側の暗号化を有効化に成功しました"

# バケットのアクセスに関する設定
printf '\r%50s' "${BUCKET_NAME}のアクセスを変更します……"
BUCKET_ACCESS_BLOCK=`cat config/config-public-access-block.json`
aws s3api put-public-access-block \
  --profile ${PROFILE_NAME} \
  --bucket ${BUCKET_NAME} \
  --public-access-block-configuration "${BUCKET_ACCESS_BLOCK}" && \
printf '\r%-50s\n' "${BUCKET_NAME}のアクセスの変更に成功しました"
