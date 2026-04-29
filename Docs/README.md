*This project has been created as part of the 42 curriculum by kmaeda.*

# Inception

## 📌 Description

Inception is a system administration project focused on containerization using Docker.  
The goal is to set up a small infrastructure composed of multiple services running in separate containers, orchestrated via Docker Compose.

The project includes:
- A web server (NGINX)
- A WordPress website (PHP-FPM)
- A database (MariaDB)
- Persistent storage using Docker volumes
- Secure configuration using environment variables and secrets

The goal is to understand how to build, configure, and connect services in a containerized environment while ensuring stability and persistence.

---

## ⚙️ Instructions

### 🔧 Requirements
- Docker
- Docker Compose
- Make

### 🚀 Installation & Launch

Clone the repository:

```bash
git clone <repo_url> inception
cd inception
```

Build and start the project:

```bash
make up
```

Stop the project:

```bash
make down
```

Clean all containers, images, and volumes:

```bash
make fclean
```

---

## 🧱 Project Architecture

The infrastructure consists of multiple containers:

* **NGINX** → reverse proxy and HTTPS handling
* **WordPress (PHP-FPM)** → dynamic website
* **MariaDB** → database
* **Volumes** → persistent storage for database and website files

All services are connected through a custom Docker network.

---

## 🐳 Docker Usage

Docker is used to isolate each service into its own container, ensuring modularity and reproducibility.

### 🔍 Sources included in the project

* Custom Dockerfiles for each service
* docker-compose.yml to orchestrate containers
* Environment variables and secrets for configuration

---

## ⚖️ Technical Choices & Comparisons

### 🆚 Virtual Machines vs Docker

| Virtual Machines     | Docker                   |
| -------------------- | ------------------------ |
| Full OS per instance | Shared host kernel       |
| Heavy and slower     | Lightweight and fast     |
| More resource usage  | Efficient resource usage |

Docker is usually chosen for its efficiency and faster deployment.

---

### 🔐 Secrets vs Environment Variables

| Secrets                      | Environment Variables |
| ---------------------------- | --------------------- |
| Secure (not exposed in logs) | Easier to use         |
| Stored safely by Docker      | Can be visible        |

Secrets are used for sensitive data like database passwords.

---

### 🌐 Docker Network vs Host Network

| Docker Network           | Host Network          |
| ------------------------ | --------------------- |
| Isolated and secure      | Direct access to host |
| Controlled communication | Less secure           |

Docker networks provide better isolation between services.

---

### 💾 Docker Volumes vs Bind Mounts

| Volumes               | Bind Mounts               |
| --------------------- | ------------------------- |
| Managed by Docker     | Linked to host filesystem |
| Portable              | Less portable             |
| Safer for persistence | More flexible             |

Volumes are used for database and WordPress data persistence.

---

## 📚 Resources

* Docker Documentation: [https://docs.docker.com/](https://docs.docker.com/)
* Docker Compose Documentation: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
* NGINX Documentation: [https://nginx.org/en/docs/](https://nginx.org/en/docs/)
* WordPress Documentation: [https://wordpress.org/documentation/](https://wordpress.org/documentation/)

### 🤖 AI Usage

AI tools were used for:

* Understanding Docker concepts
* Debugging configuration issues
* Structuring documentation
* Learning best practices for container orchestration

All configurations and implementations were manually reviewed and tested.

---

## ✅ Features

* Fully containerized infrastructure
* Persistent data storage
* Secure configuration
* Reproducible setup via Makefile

---

## 📎 Notes

This project is part of the 42 curriculum and focuses on system administration and DevOps fundamentals using Docker.
