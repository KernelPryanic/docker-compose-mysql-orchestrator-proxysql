FROM mysql:5.7-debian

ARG VERSION=3.2.6

# RUN apt-get update && apt-get install -y curl vim supervisor procps && \
#     curl -s https://packagecloud.io/install/repositories/github/orchestrator/script.deb.sh | bash && \
#     apt-get update && apt-get install -y orchestrator=${VERSION} orchestrator-cli=${VERSION} && \
#     apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get install -y curl vim supervisor procps jq && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -LO "https://github.com/openark/orchestrator/releases/download/v${VERSION}/orchestrator_${VERSION}_amd64.deb" && \
    curl -LO "https://github.com/openark/orchestrator/releases/download/v${VERSION}/orchestrator-cli_${VERSION}_amd64.deb" && \
    dpkg -i "orchestrator_${VERSION}_amd64.deb" "orchestrator-cli_${VERSION}_amd64.deb"

COPY orchestrator.sql .
COPY orchestrator.conf.json /etc/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord"]
