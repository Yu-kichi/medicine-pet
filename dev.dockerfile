FROM ruby:2.7.1 AS nodejs

WORKDIR /tmp
RUN curl -LO https://nodejs.org/dist/v14.15.0/node-v14.15.0-linux-x64.tar.xz && \
    tar xvf node-v14.15.0-linux-x64.tar.xz  && \
    mv node-v14.15.0-linux-x64 node

FROM ruby:2.7.1

COPY --from=nodejs /tmp/node /opt/node
ENV PATH=/opt/node/bin:$PATH

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH=/home/rails/.yarn/bin:/home/rails/.config/yarn/global/node_modules/.bin:$PATH

RUN gem install bundler

WORKDIR /app

RUN bundle config set path vendor/bundle

CMD ["bash"]
