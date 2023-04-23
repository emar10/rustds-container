# Rust Dedicated Server, Containerized

A no frills container image to run a single dedicated server for
[Rust](https://rust.facepunch.com/) the startup script uses
[SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) to
download/update the server, then runs with options configurable via environment
variables.

Uses the [SteamCMD project's image](https://github.com/steamcmd/docker) as a
base.

## Usage

### Environment variables

| Variable | Description | Default |
| --- | --- | --- |
| `RUSTDS_SERVER_PORT` | Main game server port to use. | `28015` |
| `RUSTDS_SERVER_LEVEL` | Level name. Should be left default at time of writing. | `"Procedural Map"` |
| `RUSTDS_SERVER_SEED` | Seed to use when generating a procedural map. | `1234` |
| `RUSTDS_SERVER_WORLDSIZE` | Size of the procedurally generated map. | `4000` |
| `RUSTDS_SERVER_MAXPLAYERS` | Maximum number of players that can connect simultaneously. | `10` |
| `RUSTDS_SERVER_HOSTNAME` | Server name to be displayed in the browser. | `Rust Dedicated Server` |
| `RUSTDS_SERVER_DESCRIPTION` | Server description. | `Containerized Rust Dedicated Server` |
| `RUSTDS_SERVER_URL` | Server URL. | `https://example.com` |
| `RUSTDS_SERVER_HEADERIMAGE` | URL pointing to a banner image for the server. (Optional) | `""` |
| `RUSTDS_SERVER_IDENTITY` | Path used to store instance saves and configuration. | `rustds` |
| `RUSTDS_SERVER_QUERYPORT` | Port used by Steam to populate the serverlist. | `28017` |
| `RUSTDS_RCON_PORT` | Port used for remote configuration. | `28016` |
| `RUSTDS_RCON_PASSWORD` | Password to authenticate RCON. | `youshouldchangethis` |
| `RUSTDS_RCON_WEB` | Whether to use the newer WebSocket-based RCON. | `1` |
| `RUSTDS_APP_PORT` | Port used for the Rust+ app. | `28082` |
| `ENABLE_EAC` | Whether to enable Easy AntiCheat (disable for Linux clients) | `1` |

### Ports

| Default Port Number | Proto |
| --- | --- |
| `28015` | UDP |
| `28016` | TCP |
| `28017` | TCP |
| `28082` | TCP |

### Volumes

| Mount Point | Description |
| --- | --- |
| `/gamedata` | Server data and saves. |


## Examples

### CLI

```
$ docker run -d -e RUSTDS_RCON_PASSWORD="password" \
                -e ENABLE_EAC=0 \
                -p 28015:28015/udp \
                -p 28016-28017:28016-28017/tcp \
                -p 28082:28082/tcp \
                -v $HOME/rustds/gamedata:/gamedata \
                ghcr.io/emar10/rustds-container:latest
``` 

### Compose

```yaml
version: '3.9'

services:
    rustds:
        image: ghcr.io/emar10/rustds-container:latest
        restart: always
        environment:
            - "RUSTDS_RCON_PASSWORD=password"
            - "ENABLE_EAC=0"
        ports:
            28015:28015/udp
            28016-28017:28016-28017/tcp
            28082:28082/tcp
        volumes:
            rustds-gamedata:/gamedata

volumes:
    rustds-gamedata
```

