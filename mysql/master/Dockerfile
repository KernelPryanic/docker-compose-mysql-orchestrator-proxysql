FROM mysql:5.7-debian

RUN apt-get update && apt-get install -y curl vim netcat iputils-ping net-tools procps

RUN mkdir -p /var/lib/mysql /var/log/mysql && chown -R mysql:mysql /var/lib/mysql /var/log/mysql
