FROM proxysql/proxysql:2.3.2

RUN apt-get update && apt-get install -y default-mysql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
