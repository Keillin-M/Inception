# Prepare for Inception Evaluation

## Virtual Machine (VM)

A VM is an emulated computer running its own operating system on top of a host machine.

**Why Inception uses a VM**

* Environment isolation
* Same setup for every student
* Simulates real server deployment
* Docker runs inside the VM, not on the host

Examples:

* VirtualBox / UTM
* Debian (recommended by subject)

---

## Docker

Docker is a containerization platform that packages applications with their dependencies into **containers**.

### Docker vs VM

* **VM**: runs a full OS with its own kernel
* **Docker**: shares the host kernel, lightweight and fast

### Image vs Container

* **Image**: blueprint (read-only)
* **Container**: running instance of an image

---

## Dockerfile

A Dockerfile is a text file that defines how a Docker image is built.

Common instructions:

```Dockerfile
FROM debian:bullseye
RUN apt update && apt install -y nginx
COPY conf /etc/nginx/
CMD ["nginx", "-g", "daemon off;"]
```

### Key points

* `FROM`: base image
* `RUN`: executes commands at build time
* `COPY`: copies files into the image
* `CMD`: command executed when container starts
* Only **one main process** per container

---

## Docker Compose

Docker Compose is a tool to define and manage **multi-container applications**.

Why use it:

* Start all services with one command
* Manage networks and volumes
* Cleaner than running many `docker run` commands

### docker-compose.yml structure

```yaml
services:
volumes:
networks:
```

### Important keywords

* `build`: builds image from Dockerfile
* `image`: uses an existing image
* `depends_on`: controls startup order (not readiness)
* `env_file`: loads environment variables
* `restart: unless-stopped`

---

## Containers in Inception

### NGINX

* Acts as a reverse proxy
* Handles HTTPS (TLS)
* Exposes port **443 only**

Why NGINX?

* Performance
* Security
* Industry standard

---

### WordPress (PHP-FPM)

* Runs PHP application
* Does NOT expose ports
* Communicates with NGINX and MariaDB through Docker network

---

### MariaDB

* Relational database
* Stores WordPress data
* Not exposed to host (no open ports)

Why not expose MariaDB?

* Security
* Only WordPress needs access

---

## Docker Networks

Docker creates a **private virtual network** for containers.

Key points:

* Containers communicate using **service names**
* `localhost` inside a container refers to itself
* Example: WordPress connects to `mariadb`, not `127.0.0.1`

---

## Volumes

Volumes persist data outside containers.

Why volumes are required:

* Containers are ephemeral
* Data would be lost on container deletion

### Required volumes

* MariaDB data: `/var/lib/mysql`
* WordPress files: `/var/www/html`

### Volume location on VM

```bash
/var/lib/docker/volumes/
```

---

## TLS / SSL

TLS encrypts data between client and server.

### In Inception

* HTTPS required
* Self-signed certificate allowed
* Port 443 only

NGINX config example:

```nginx
listen 443 ssl;
ssl_certificate /etc/nginx/ssl/cert.pem;
ssl_certificate_key /etc/nginx/ssl/key.pem;
```

---

## Environment Variables

Used to store configuration and secrets.

Examples:

* Database name
* Database user
* Database password

Best practices:

* Use `.env` file
* Do NOT hardcode passwords in Dockerfiles
* Do NOT commit secrets to Git

---

## Container Lifecycle

Important commands:

```bash
docker build
docker run
docker stop
docker rm
docker exec
```

Compose lifecycle:

```bash
docker-compose up --build
docker-compose down
docker-compose down -v
```

Difference:

* `down`: removes containers
* `down -v`: removes containers **and volumes**

---

## Useful Docker Commands

```bash
docker ps
docker images
docker volume ls
docker network ls
docker logs <container>
docker exec -it <container> bash
```

---

## Common Evaluation Questions

* Why use Docker instead of installing everything directly?
* Why only NGINX exposes a port?
* Why WordPress can’t connect to MariaDB via localhost?
* What happens if you delete a container?
* How does data persist?
* Difference between CMD and RUN?
* What is the role of Docker Compose?

---

## Common Mistakes (Avoid These)

* Using `latest` tag
* Hardcoding passwords
* Exposing database ports
* Not understanding your Dockerfiles
* Containers restarting endlessly
* Saying “I followed a tutorial” without explanation

---

## Final Check Before Evaluation

* Can rebuild project from scratch
* Can explain every file in `srcs/`
* Can explain architecture verbally
* Can troubleshoot live if something breaks

