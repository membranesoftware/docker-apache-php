FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends apache2 php libapache2-mod-php

# Source bundles are expected to be populated by the top-level make process
COPY www.tar.gz /var/www/
RUN cd /var/www && sync && rm -rf html && sync && tar zxvf www.tar.gz && mv www html && rm -f www.tar.gz && chown -R www-data:www-data html && chmod -R u=rX,g=rX,o=rX html

EXPOSE 80
CMD /usr/sbin/apachectl -D FOREGROUND
