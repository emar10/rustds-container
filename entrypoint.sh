#!/bin/bash

set -e

echo Installing/Updating Rust Dedicated Server...
steamcmd +@ShutdownOnFailedCommand 1 \
         +force_install_dir /gamedata \
         +login anonymous \
         +app_update 258550 \
         +exit

echo Launching server...
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/gamedata/RustDedicated_Data/Plugins/x86_64:/gamedata/RustDedicated_Data/Plugins
pushd /gamedata
./RustDedicated -batchmode \
                +server.port "${RUSTDS_SERVER_PORT}" \
                +server.level "${RUSTDS_SERVER_LEVEL}" \
                +server.seed "${RUSTDS_SERVER_SEED}" \
                +server.worldsize "${RUSTDS_SERVER_WORLDSIZE}" \
                +server.maxplayers "${RUSTDS_SERVER_MAXPLAYERS}" \
                +server.hostname "${RUSTDS_SERVER_HOSTNAME}" \
                +server.description "${RUSTDS_SERVER_DESCRIPTION}" \
                +server.url "${RUSTDS_SERVER_URL}" \
                +server.headerimage "${RUSTDS_SERVER_HEADERIMAGE}" \
                +server.identity "${RUSTDS_SERVER_IDENTITY}" \
                +server.queryport "${RUSTDS_SERVER_QUERYPORT}" \
                +rcon.port "${RUSTDS_RCON_PORT}" \
                +rcon.password "${RUSTDS_RCON_PASSWORD}" \
                +rcon.web "${RUSTDS_RCON_WEB}" \
                +app.port "${RUSTDS_APP_PORT}" \
                +server.secure "${ENABLE_EAC}" \

