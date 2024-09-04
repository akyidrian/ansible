FROM ubuntu:jammy AS base
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
    && apt-get clean autoclean  \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/apt/lists/*

FROM base AS ansible-tester
RUN addgroup --gid 1000 tester \
    && adduser --gecos tester --uid 1000 --gid 1000 --disabled-password tester \
    && adduser tester sudo
RUN echo "tester ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/tester \
    && chmod 0440 /etc/sudoers.d/tester
USER tester
WORKDIR /home/tester
