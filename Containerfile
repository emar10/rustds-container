# Rust Dedicated Server

FROM docker.io/steamcmd/steamcmd:ubuntu
LABEL maintainer="ethan@emar10.dev"

# Volumes
RUN mkdir /gamedata
VOLUME [ "/gamedata" ]

# Environment Variables
ENV RUSTDS_SERVER_PORT="28015"
ENV RUSTDS_SERVER_LEVEL="Procedural Map"
ENV RUSTDS_SERVER_SEED="1234"
ENV RUSTDS_SERVER_WORLDSIZE="4000"
ENV RUSTDS_SERVER_MAXPLAYERS="10"
ENV RUSTDS_SERVER_HOSTNAME="Rust Dedicated Server"
ENV RUSTDS_SERVER_DESCRIPTION="Containerized Rust Dedicated Server"
ENV RUSTDS_SERVER_URL="https://example.com"
ENV RUSTDS_SERVER_HEADERIMAGE=""
ENV RUSTDS_SERVER_IDENTITY="rustds"
ENV RUSTDS_SERVER_QUERYPORT="28017"
ENV RUSTDS_RCON_PORT="28016"
ENV RUSTDS_RCON_PASSWORD="youshouldchangethis"
ENV RUSTDS_RCON_WEB="1"
ENV RUSTDS_APP_PORT="28082"
ENV ENABLE_EAC="1"
ENV INSTALL_UMOD="0"

# Ports
EXPOSE ${RUSTDS_SERVER_PORT}/udp
EXPOSE ${RUSTDS_SERVER_QUERYPORT}/tcp
EXPOSE ${RUSTDS_RCON_PORT}/tcp
EXPOSE ${RUSTDS_APP_PORT}/tcp

# Install curl
RUN apt-get update; \
    apt-get install -y curl unzip; \
    rm -rf /var/lib/apt/lists/*

# Copy Entrypoint Script
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
