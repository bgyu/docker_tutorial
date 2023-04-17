# Use docker compose to start services
`compose.yaml`, `compose.yml`, `docker-compose.yaml`, `docker-compose.yml` are all default names for `docker compose`.
You can use any of them. Usually it is `compose.yaml` or `compose.yml`.

`docker compose` does NOT build any docker images, it just uses existing docker images to start docker containers defined in `compose.yaml`.

```bash
# Start docker services defined in compose.yaml in deamon/detached mode
docker compose up -d
```

# Use docker compose to bring down all services
```bash
# Stop and delete all docker containers defined in compose.yaml
docker compose down
```
