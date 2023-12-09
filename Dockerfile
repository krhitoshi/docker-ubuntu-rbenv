FROM ubuntu:22.04

ENV RUBY_VERSION 3.2.2

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential libyaml-dev zlib1g-dev libssl-dev \
    git curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc

ENV PATH=/root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

RUN rbenv install $RUBY_VERSION && rm -f /tmp/ruby-build.*.log
RUN rbenv global $RUBY_VERSION

CMD [ "irb" ]
