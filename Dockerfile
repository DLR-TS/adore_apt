FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    dpkg-dev \
    gzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /repo

COPY setup-apt-repo.sh /usr/local/bin/setup-apt-repo.sh

RUN chmod +x /usr/local/bin/setup-apt-repo.sh

COPY packages . 

ENTRYPOINT ["/usr/local/bin/setup-apt-repo.sh"]

