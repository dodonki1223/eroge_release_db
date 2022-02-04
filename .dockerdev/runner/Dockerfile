ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG PG_MAJOR
ARG NODE_MAJOR
ARG YARN_VERSION
ARG BUNDLER_VERSION

# Common dependencies
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
    wget && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

# Add Yarn to the sources list
# https://classic.yarnpkg.com/en/docs/install#debian-stable
# M1 Mac だとうまくいかないため、curl コマンドでなく wget コマンドを使用する
#   https://askubuntu.com/questions/1108339/gpg-no-valid-openpgp-error-when-i-try-to-install-yarn-on-ubuntu-18-04

# Warning: apt-key output should not be parsed (stdout is not a terminal) のエラーが出るため、APT_KEY_DONT_WARN_ON_DANGEROUS_USAGEの環境変数を追加する
#   https://code.visualstudio.com/remote/advancedcontainers/reduce-docker-warnings
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

# hadolint ignore=DL4006
RUN wget --quiet -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# パイプライン内のコマンドがエラーとなった時に中断するオプション
#   これがないとパイプライン時に途中で失敗しているが最後が成功しているような時は
#   成功とみなされてしまうため、この設定が必要である
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Add PostgreSQL to sources list
# https://www.postgresql.org/download/linux/debian/
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

# Add NodeJS to sources list
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install dependencies
COPY .dockerdev/Aptfile /tmp/Aptfile
# hadolint ignore=SC2002,SC2046
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
    nodejs \
    yarn=$YARN_VERSION-1 \
    $(cat /tmp/Aptfile | xargs) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

# Bundler Settings
ENV LANG=C.UTF-8\
    GEM_HOME=/bundle\
    BUNDLE_JOBS=4\
    BUNDLE_RETRY=3

# Uncomment this line if you store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=$GEM_HOME\
    BUNDLE_BIN=$BUNDLE_PATH/bin

# Uncomment this line if you want to run binstubs without prefixing with `bin/` or `bundle exec`
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

# Create a directory for the app code
RUN mkdir -p /app

WORKDIR /app
