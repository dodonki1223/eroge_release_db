# README

[![CircleCI](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master.svg?style=svg)](https://circleci.com/gh/dodonki1223/eroge_release_db/tree/master)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 実際にやったこと

### Gemfileにpgを追加

```ruby
# Use PostgresSQL as the database for Active Record
gem 'pg', '~> 1.2.2'
```

### database.ymlを変更

```yml
default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  encoding: utf8
  username: root
  password:
  host: postgres
  port: 5432

development:
  <<: *default
  database: dev_eroge_release

test:
  <<: *default
  database: test_eroge_release

production:
  <<: *default
  database: prod_eroge_release
```
 