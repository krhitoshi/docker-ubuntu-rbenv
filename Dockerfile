FROM krhitoshi/ubuntu-rbenv:22.04

ARG RUBY_VERSION=3.2.2
ENV RUBY_VERSION $RUBY_VERSION

RUN CONFIGURE_OPTS="--disable-install-doc --disable-install-rdoc --disable-install-capi" \
    rbenv install $RUBY_VERSION && rm -f /tmp/ruby-build.*.log
RUN rbenv global $RUBY_VERSION

CMD [ "irb" ]
