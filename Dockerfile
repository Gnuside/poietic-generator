FROM debian:testing
MAINTAINER Glenn Y. Rolland <glenux@glenux.net>

# Install packages for building ruby
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -q -y ruby2.1 git ruby2.1-dev
RUN apt-get install -q -y make libmysqlclient-dev mysql-client

RUN useradd -m user
RUN chown -R user:user /home/user
RUN gem2.1 install bundler


# TESTING
RUN mkdir -p /home/user/.cache && cd /home/user/.cache && git init
ADD lib/poieticgen/version.rb /home/user/.cache/lib/poieticgen/version.rb
ADD poieticgen.gemspec /home/user/.cache/poieticgen.gemspec
ADD Gemfile.lock /home/user/.cache/Gemfile.lock
ADD Gemfile /home/user/.cache/Gemfile
RUN chown -R user:user /home/user

WORKDIR /home/user/.cache
USER user
RUN find .
RUN bundle install --path /home/user/.bundle/

ADD . /home/user/poieticgen

# WORKING
#ADD . /home/user/poieticgen
#RUN chown -R user:user /home/user
#WORKDIR /home/user/poieticgen
#USER user
#RUN find .
#RUN bundle install --path /home/user/.bundle/

USER root
RUN chown -R user:user /home/user
ADD misc/docker-start.sh /usr/local/sbin/start
RUN chmod +755 /usr/local/sbin/start

EXPOSE 8000
CMD /usr/local/sbin/start

