ARG UBUNTU_VERSION=22.04
FROM krhitoshi/ubuntu-rbenv:${UBUNTU_VERSION}

ARG RUBY_VERSION=3.2.2
ENV RUBY_VERSION=${RUBY_VERSION}

# disable-install-doc options don't work with ruby 3.0.6
# 3.0.6: --build-arg CONFIGURE_OPTS=""
ARG CONFIGURE_OPTS="--disable-install-doc --disable-install-rdoc --disable-install-capi"
ENV CONFIGURE_OPTS=${CONFIGURE_OPTS}

# Upgrade ruby-build plugin
#   If you need a newer Ruby version, uncomment the next line to update the plugin first.
#RUN git -C "$(rbenv root)"/plugins/ruby-build pull

RUN rbenv install ${RUBY_VERSION} && rm -f /tmp/ruby-build.*.log
RUN rbenv global ${RUBY_VERSION}

CMD [ "irb" ]
