FROM signal18/replication-manager

ARG password=secretpass

RUN replication-manager keygen && echo $(replication-manager password ${password})
