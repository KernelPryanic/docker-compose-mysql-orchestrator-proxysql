FROM signal18/replication-manager

# ARG password=secretpass
# RUN replication-manager keygen && echo $(replication-manager password ${password})

RUN apt-get update && apt-get install -y jq && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
