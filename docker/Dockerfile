FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends apache2 php libapache2-mod-php
EXPOSE 80
CMD /usr/sbin/apachectl -D FOREGROUND
