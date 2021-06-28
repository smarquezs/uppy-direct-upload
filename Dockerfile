FROM phusion/passenger-ruby25

LABEL maintainer="Sergio Márquez <smarquezs@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV WORKDIR /home/app/webapp

# Add  node 12.x repository
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update && \
      apt-get install --yes --no-install-recommends \
      libmagickwand-dev \
      imagemagick \
      nodejs && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g yarn

# Enable nginx + passenger
RUN rm -f /etc/service/nginx/down

# Remove default nginx site
RUN rm /etc/nginx/sites-enabled/default

# Add rails application to sites-enabled
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

RUN gem install bundler -v '2.2.15'

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile* /tmp/
RUN bundle install -j4

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}
COPY . .

RUN chown -R app:app .
