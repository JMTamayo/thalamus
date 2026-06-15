# thalamus

A self-hosted MQTT infrastructure stack, orchestrated with Docker Compose. It
bundles an [Eclipse Mosquitto](https://mosquitto.org/) broker for messaging and
[Portainer](https://www.portainer.io/) for container management, each defined as
an independent module with its own image and configuration.

## Architecture

| Service | Image | Purpose | Ports |
| --- | --- | --- | --- |
| `mosquitto` | `eclipse-mosquitto:2.0.22` | MQTT broker with authentication and ACLs | `1883` (MQTT), `9001` (WebSockets) |
| `portainer` | `portainer/portainer-ce:2.37.0` | Web UI to manage the Docker environment | `9443` (HTTPS) |

All services run on the `thalamus-network` bridge network and persist their data
in named Docker volumes.

## Project structure

```
.
├── docker-compose.yml      # Stack definition
├── Makefile                # docker compose lifecycle commands
├── mosquitto/              # MQTT broker module
│   ├── Dockerfile
│   ├── Makefile            # Broker configuration commands
│   ├── README.md           # Broker setup guide
│   └── config/             # mosquitto.conf, passwd.txt, acl.conf
└── portainer/              # Container management module
    ├── Dockerfile
    ├── README.md           # Admin password setup guide
    └── config/             # Admin password file
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and Docker Compose
- [Mosquitto CLI tools](https://mosquitto.org/download/) (for creating broker
  credentials locally)

## Setup

Each module ships with credentials that are not committed to the repository, so
they must be created before the first run.

1. **Mosquitto** — create the users and ACLs as described in
   [mosquitto/README.md](mosquitto/README.md).
2. **Portainer** — define the default admin password as described in
   [portainer/README.md](portainer/README.md).

## Usage

The root [Makefile](Makefile) wraps the common Docker Compose commands. Run
`make help` to list every target.

```bash
make up        # Start the stack in detached mode
make build     # Build (or rebuild) images and start the stack
make logs      # Follow the logs
make ps        # List the running containers
make down      # Stop and remove the stack
```

Most targets accept an optional `SERVICE` variable to act on a single service:

```bash
make logs SERVICE=mosquitto
make build SERVICE=portainer
```

Equivalent raw commands are also available:

```bash
docker compose up -d      # Start
docker compose down       # Stop
```

Once running, Portainer is available at https://localhost:9443 and the MQTT
broker listens on `localhost:1883` (and `localhost:9001` for WebSockets).

## License

Released under the [MIT License](LICENSE).
